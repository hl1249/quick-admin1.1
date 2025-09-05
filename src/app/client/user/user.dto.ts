import { IsString, Matches, IsNotEmpty, Length } from 'class-validator';

export class UserDto {
  @IsString()
  @IsNotEmpty()
  @Length(4, 16, { message: '用户名长度必须在4到16之间' })
  username: string;

  @IsString()
  @IsNotEmpty()
  @Length(6, 20, { message: '密码长度必须在6到15之间' })
  password: string;
}