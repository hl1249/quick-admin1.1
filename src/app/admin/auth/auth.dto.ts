import { IsString, IsNotEmpty, Length } from 'class-validator';

export class UserDto {
  @IsString()
  @IsNotEmpty()
  @Length(4, 16, { message: '用户名长度必须在4到16之间' })
  username: string;

  @IsString()
  @IsNotEmpty()
  @Length(6, 20, { message: '密码长度必须在6到20之间' })
  password: string;
}

/** 注册 DTO，与登录共用校验规则 */
export class RegisterDto extends UserDto {}