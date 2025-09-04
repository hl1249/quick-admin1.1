import { Injectable } from '@nestjs/common';
import { JwtService as JwtServiceNest } from '@nestjs/jwt';

@Injectable()
export class JwtService {
    constructor(private readonly jwtService: JwtServiceNest) { }

    // 生成 token
    async generateToken(userId: string): Promise<string> {
        const payload = { userId }; // 可以根据需要添加其他信息
        return this.jwtService.sign(payload);
    }

    verifyToken(token: string): any {
        try {
            return this.jwtService.verify(token);
        } catch (e) {
            return null;
        }
    }

    // 仅解码 token，不验证
    decodeToken(token: string): any {
        return this.jwtService.decode(token);
    }

    // 获取 token 的过期时间
    getExpired(token: string): number | null {
        const decoded = this.decodeToken(token);
        if (decoded && decoded.exp) {
            return decoded.exp * 1000; // 将过期时间转换为毫秒
        }
        return null; // 如果没有找到 exp 字段，返回 null
    }

    // 验证 token 数组，只返回合法的
    verifyTokens(tokens: string[]): any[] {
        const validTokens = tokens.map((token) => {
            if (this.verifyToken(token)) {
                return token
            }
        })
        return validTokens;
    }
}