import {
  IsNotEmpty,
  IsBoolean,
  IsOptional,
  IsString,
  IsArray,
} from 'class-validator';

export class AddMenuDto {
  @IsNotEmpty({ message: '请填写菜单ID' })
  menu_id: string;

  @IsNotEmpty({ message: '请填写菜单标题' })
  title: string;

  @IsOptional()
  parent_id?: string;

  @IsOptional()
  component?: string;

  @IsOptional()
  path?: string;

  @IsOptional()
  @IsBoolean()
  enable?: boolean;

  @IsOptional()
  comment?: string;

  @IsArray()
  url?: string[];
}

export class UpdateMenuDto {
  @IsNotEmpty()
  @IsString()
  _id: string;

  @IsOptional()
  menu_id?: string;

  @IsOptional()
  title?: string;

  @IsOptional()
  parent_id?: string;

  @IsOptional()
  component?: string;

  @IsOptional()
  path?: string;

  @IsOptional()
  @IsBoolean()
  enable?: boolean;

  @IsOptional()
  comment?: string;

  @IsOptional()
  url?: string[];
}