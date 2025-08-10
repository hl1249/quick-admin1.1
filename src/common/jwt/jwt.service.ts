import { Injectable } from '@nestjs/common';
import { JwtService as JwtServiceNest } from '@nestjs/jwt';

@Injectable()
export class JwtService {
    constructor(private readonly jwtService: JwtServiceNest) {}

    generateToken(payload: any): string {
        return this.jwtService.sign(payload);
    }

    verifyToken(token: string): any {
        try {
            return this.jwtService.verify(token);
        } catch (e) {
            return null;
        }
    }
}