import { IsString, IsOptional, IsArray, ValidateNested, MinLength } from 'class-validator';
import { Type } from 'class-transformer';

export class ChatMessageDto {
  @IsString()
  role: 'user' | 'assistant' | 'system';

  @IsString()
  content: string;
}

export class ChatDto {
  @IsString()
  @MinLength(1, { message: '消息内容不能为空' })
  message: string;

  @IsOptional()
  @IsString()
  system?: string;

  @IsOptional()
  @IsArray()
  @ValidateNested({ each: true })
  @Type(() => ChatMessageDto)
  history?: ChatMessageDto[];
}

export class FindFilesDto {
  @IsOptional()
  @IsString()
  folder?: string;

  @IsOptional()
  @IsArray()
  @IsString({ each: true })
  extensions?: string[];

  @IsOptional()
  recursive?: boolean;

  @IsOptional()
  maxResults?: number;
}

export class ReadFileDto {
  @IsString()
  path: string;

  @IsOptional()
  maxBytes?: number;
}

export class WriteFileDto {
  @IsString()
  path: string;

  @IsString()
  content: string;
}

export class EditFileDto {
  @IsString()
  path: string;

  @IsString()
  oldText: string;

  @IsString()
  newText: string;
}
