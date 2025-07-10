import { Injectable } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';

@Injectable()
export class AuthService {
  constructor(private readonly jwtService: JwtService) {}

  private readonly admin = {
    username: 'admin',
    password: 'admin123',
  };

  validateUser(
    username: string,
    password: string,
  ): { username: string } | null {
    if (username === this.admin.username && password === this.admin.password) {
      return { username };
    }
    return null;
  }

  login(user: { username: string }): { access_token: string } {
    const payload = { username: user.username };
    const token = this.jwtService.sign(payload);
    return { access_token: token };
  }
}
