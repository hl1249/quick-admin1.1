import {
  BadRequestException,
  Body,
  Controller,
  Ip,
  Post,
  SetMetadata,
} from '@nestjs/common';
import { Document } from 'mongodb';
import { DbService } from '@/common/db/db.service';
import { JwtService } from '@/common/jwt/jwt.service';
import { AppConfigService } from '@/config/app-config.service';
import { filterObject } from '@/common/utils/utils';

interface GetAppInfoDto {
  appid?: string;
}

interface LoginByWeixinDto {
  appid?: string;
  code?: string;
}

interface AppidConfig {
  appid?: string;
  appname?: string;
  secret?: string;
}

interface WeixinCode2SessionResponse {
  openid?: string;
  session_key?: string;
  unionid?: string;
  errcode?: number;
  errmsg?: string;
}

interface QaUser {
  _id: {
    toHexString(): string;
  };
  appid?: string;
  appname?: string;
  openid?: string;
  unionid?: string;
  nickname?: string;
  token?: string[];
  password?: string;
  [key: string]: unknown;
}

@Controller()
export class AppidController {
  constructor(
    private readonly dbService: DbService,
    private readonly jwtService: JwtService,
    private readonly appConfig: AppConfigService,
  ) {}

  private createRandomNickname(length = 6): string {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    return Array.from({ length }, () =>
      chars.charAt(Math.floor(Math.random() * chars.length)),
    ).join('');
  }

  @SetMetadata('skipAuth', true)
  @Post('/getAppInfo')
  getAppInfo(@Body() data: GetAppInfoDto): Promise<Document | null> {
    const { appid } = data;

    return this.dbService.findByWhereJson({
      dbName: 'qa-appids',
      whereJson: {
        appid,
      },
    });
  }

  @SetMetadata('skipAuth', true)
  @Post('/loginByWeixin')
  async loginByWeixin(
    @Body() data: LoginByWeixinDto,
    @Ip() ipAddress: string,
  ): Promise<Document | null> {
    const { appid, code } = data;

    if (!appid) {
      throw new BadRequestException('appid 不能为空');
    }

    if (!code) {
      throw new BadRequestException('code 不能为空');
    }

    const appInfo = (await this.dbService.findByWhereJson({
      dbName: 'qa-appids',
      whereJson: {
        appid,
      },
      fieldJson: {
        appid: true,
        secret: true,
        appname: true,
      },
    })) as AppidConfig | null;

    if (!appInfo?.secret) {
      throw new BadRequestException('未找到对应的小程序配置');
    }

    const url = new URL('https://api.weixin.qq.com/sns/jscode2session');
    url.searchParams.set('appid', appid);
    url.searchParams.set('secret', String(appInfo.secret));
    url.searchParams.set('js_code', code);
    url.searchParams.set('grant_type', 'authorization_code');

    const response = await fetch(url.toString(), { redirect: 'follow' });

    if (!response.ok) {
      throw new BadRequestException('微信登录请求失败');
    }

    const weixinRes = (await response.json()) as WeixinCode2SessionResponse;

    if (weixinRes.errcode) {
      throw new BadRequestException(
        weixinRes.errmsg || '微信登录获取 openid 失败',
      );
    }

    if (!weixinRes.openid) {
      throw new BadRequestException('微信登录未返回 openid');
    }

    let userInfo = (await this.dbService.findByWhereJson({
      dbName: 'qa-users',
      whereJson: {
        appid,
        openid: weixinRes.openid,
      },
    })) as QaUser | null;

    if (!userInfo) {
      const { insertedId } = await this.dbService.add({
        dbName: 'qa-users',
        dataJson: {
          appid,
          appname: appInfo.appname,
          openid: weixinRes.openid,
          unionid: weixinRes.unionid,
          nickname: this.createRandomNickname(),
          role: [],
          token: [],
          enable: true,
        },
      });

      userInfo = (await this.dbService.findById({
        dbName: 'qa-users',
        id: insertedId.toHexString(),
      })) as QaUser | null;
    }

    if (!userInfo) {
      throw new BadRequestException('微信用户注册失败，请重试');
    }

    const token = await this.jwtService.generateToken(
      userInfo._id.toHexString(),
    );
    const validTokens = this.jwtService
      .verifyTokens(userInfo.token || [])
      .filter((item): item is string => typeof item === 'string');
    const passTokens = [...validTokens, token].slice(
      -this.appConfig.tokenMaxLimit,
    );

    const nextNickname =
      typeof userInfo.nickname === 'string' && userInfo.nickname
        ? userInfo.nickname
        : this.createRandomNickname();

    await this.dbService.update({
      dbName: 'qa-users',
      whereJson: {
        _id: userInfo._id,
      },
      dataJson: {
        appid,
        appname: appInfo.appname,
        openid: weixinRes.openid,
        unionid: weixinRes.unionid,
        nickname: nextNickname,
        last_login_date: Date.now(),
        last_login_ip: ipAddress?.startsWith('::ffff:')
          ? ipAddress.substring(7)
          : '未知IP',
        token: passTokens,
      },
    });

    const latestUserInfo = (await this.dbService.findById({
      dbName: 'qa-users',
      id: userInfo._id.toHexString(),
    })) as QaUser | null;

    if (!latestUserInfo) {
      throw new BadRequestException('微信登录失败，请重试');
    }

    return {
      token,
      expired: this.jwtService.getExpired(token),
      userInfo: filterObject(latestUserInfo, ['password', 'token'], false),
    };
  }
}
