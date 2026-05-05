import { IsString, IsOptional, IsEnum, IsArray, MinLength, IsObject } from 'class-validator';

export enum GenerateType {
  VUE_COMPONENT = 'vue_component',
  MODEL = 'model',
  CONTROLLER = 'controller',
  SERVICE = 'service',
  API = 'api',
}

export enum TargetSide {
  FRONTEND = 'frontend',
  BACKEND = 'backend',
}

export class GenerateCodeDto {
  @IsEnum(GenerateType)
  type: GenerateType;

  @IsString()
  @MinLength(1, { message: '名称不能为空' })
  name: string;

  @IsOptional()
  @IsString()
  description?: string;

  @IsOptional()
  @IsString()
  targetPath?: string;

  @IsOptional()
  @IsObject()
  schema?: Record<string, any>;

  @IsOptional()
  @IsArray()
  @IsString({ each: true })
  fields?: string[];

  @IsOptional()
  @IsString()
  template?: string;
}

export class AnalyzeCodeDto {
  @IsString()
  path: string;

  @IsOptional()
  @IsString()
  analysisType?: 'structure' | 'performance' | 'security' | 'best-practices';
}

export class CreateModuleDto {
  @IsString()
  @MinLength(1)
  moduleName: string;

  @IsOptional()
  @IsString()
  description?: string;

  @IsOptional()
  @IsArray()
  @IsString({ each: true })
  features?: string[];

  @IsOptional()
  @IsEnum(TargetSide)
  targetSide?: TargetSide;
}
