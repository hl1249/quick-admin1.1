import {
  Injectable,
  BadRequestException,
  UnauthorizedException,
} from '@nestjs/common';
import { DbService } from '@/common/utils/db.service';
import { Document } from 'mongodb'
import { UserDto, RegisterDto } from './auth.dto';
import { PASSWORD_SECRET, TOKEN_MAX_LIMIT, ADMIN_ROLE_ID } from '@/config';
import { JwtService } from '@/common/jwt/jwt.service';
import { arrayToTree, filterObject } from '@/common/utils/utils'
import { CacheService } from '@/common/cache/cache.service'
import { _ } from '@/common/utils/fieldQueryTemp';
import * as bcrypt from 'bcryptjs';

@Injectable()
export class AuthService {
  // private readonly logger = new Logger(AuthService.name);

  constructor(
    private readonly dbService: DbService,
    private readonly jwtService: JwtService,
    private readonly cache: CacheService,
  ) {}

  async register(
    registerDto: RegisterDto,
    ipAddress: string,
  ): Promise<Document | null> {
    const { username, password } = registerDto;
    const existUser = await this.dbService.findByWhereJson({
      dbName: 'qa-users',
      whereJson: { username },
    });
    if (existUser) {
      throw new BadRequestException('用户名已存在');
    }
    const hashedPassword = await bcrypt.hash(
      password + PASSWORD_SECRET,
      10,
    );
    const { insertedId } = await this.dbService.add({
      dbName: 'qa-users',
      dataJson: {
        username,
        password: hashedPassword,
        role: [],
        token: [],
      },
    });
    const userInfo = await this.dbService.findById({
      dbName: 'qa-users',
      id: insertedId.toHexString(),
    });
    if (!userInfo) {
      throw new BadRequestException('注册失败，请重试');
    }
    // 注册成功后自动登录，返回与 login 一致的结构
    const token = await this.jwtService.generateToken(userInfo._id.toHexString());
    const passTokens = [
      ...this.jwtService.verifyTokens(userInfo.token || []),
      token,
    ].slice(-TOKEN_MAX_LIMIT);
    await this.dbService.update({
      dbName: 'qa-users',
      whereJson: { _id: userInfo._id },
      dataJson: {
        last_login_date: Date.now(),
        last_login_ip: ipAddress?.startsWith('::ffff:')
          ? ipAddress.substring(7)
          : '未知IP',
        token: passTokens,
      },
    });
    await this.buildCacheUserPermission(userInfo);
    return {
      token,
      expired: this.jwtService.getExpired(
        await this.jwtService.generateToken(userInfo._id.toHexString()),
      ),
      userInfo: filterObject(userInfo, ['password', 'token'], false),
    };
  }

  async login(
    userDto: UserDto,
    ipAddress: string,
  ): Promise<Document | null> {
    const { username, password } = userDto;
    const userInfo = await this.dbService.findByWhereJson({
      dbName: 'qa-users',
      whereJson: {
        username,
      },
    });

    if (!userInfo) {
      throw new BadRequestException('账号或密码错误');
    }

    const isMatch = await bcrypt.compare(
      password + PASSWORD_SECRET,
      userInfo.password,
    ); // 使用密钥解密密码

    if (!isMatch) {
      throw new BadRequestException('账号或密码错误');
    }

    const token = await this.jwtService.generateToken(
      userInfo._id.toHexString(),
    );

    const passTokens = [
      ...this.jwtService.verifyTokens(userInfo.token || []), // 过滤掉过期 token
      token, // 添加新 token
    ].slice(-TOKEN_MAX_LIMIT); // 保留最后 TOKEN_MAX_LIMIT 个

    await this.dbService.update({
      dbName: 'qa-users',
      whereJson: {
        _id: userInfo._id,
      },
      dataJson: {
        last_login_date: Date.now(),
        last_login_ip: ipAddress?.startsWith('::ffff:')
          ? ipAddress.substring(7)
          : '未知IP', // 保存最后登录ip
        token: passTokens, // 保存token到数组
      },
    });

    await this.buildCacheUserPermission(userInfo);
    return {
      token,
      expired: this.jwtService.getExpired(
        await this.jwtService.generateToken(userInfo._id.toHexString()),
      ),
      userInfo: filterObject(userInfo, ['password', 'token'], false),
    };
  }

  async getMenu(req): Promise<any> {
    const { userInfo } = req;
    const userId = userInfo._id.toHexString();
    const cachedPermissions = (await this.cache.get<{ allowedMenus: string[] }>(
      `auth:${userId}`,
    ))!;

    if (!cachedPermissions) throw new UnauthorizedException('身份认证失败');
    let whereJson = {};
    if (!userInfo.role.includes(ADMIN_ROLE_ID)) {
      whereJson = {
        menu_id: _.in(cachedPermissions.allowedMenus),
      };
    }

    const res = await this.dbService.selects({
      dbName: 'qa-menus',
      whereJson,
      getMain: true,
      pageSize: 200,
      sortArr: [
        {
          name: 'sort',
          type: 'asc',
        },
      ],
    });

    let treeProps = {
      id: 'menu_id',
      parent_id: 'parent_id',
      children: 'children',
    };

    return {
      res,
      menus: arrayToTree(res as Document[], treeProps),
    };
  }

  // 构建用户权限缓存信息
  async buildCacheUserPermission(userInfo: any): Promise<any> {
    // 获取或初始化 authVersion，如果不存在则从 0 递增到 1
    const authVersion: number =
      (await this.cache.get<number>('authVersion')) ??
      (await this.cache.incr('authVersion'));

    const permissionsUrlList = await this.dbService.selects({
      dbName: 'qa-roles',
      getMain: true,
      whereJson: {
        role_id: _.in(userInfo.role),
      },
      foreignDB: [
        {
          dbName: 'qa-permissions',
          localKey: 'permission',
          localKeyType: 'array',
          foreignKey: 'permission_id',
          as: 'user_permission',
          fieldJson: {
            url: true,
            _id: false,
            match_mode: true, //匹配模式 0 完整路径  1 通配符 2 正则
          },
        },
      ],
    });

    const userId = userInfo._id.toHexString();
    await this.cache.set(`auth:${userId}`, {
      allowedMenus: [
        ...new Set(permissionsUrlList.flatMap((item) => item.menu)),
      ],
      permissionConfigs: permissionsUrlList.flatMap((item) =>
        item.user_permission.map((it: any) => ({
          url: it.url,
          match_mode: it.match_mode !== undefined ? it.match_mode : 1, // 默认通配符模式
        })),
      ),
      role_ids: permissionsUrlList.map((item) => item.role_id),
      authVersion,
    });
  }

  // 修改角色权限后，递增版本号（不删除缓存，通过版本控制自动失效）
  async updateAuthVersion(): Promise<any> {
    await this.cache.incr('authVersion');
  }
}