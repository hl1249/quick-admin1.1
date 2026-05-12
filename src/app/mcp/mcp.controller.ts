import {
  Controller,
  Post,
  Body,
  HttpCode,
  HttpStatus,
  Get,
  Query,
  Res,
  ForbiddenException,
} from '@nestjs/common';
import { McpService, ChatMessage } from './mcp.service';
import { FileService } from './tools/file.service';
import { CodeGeneratorService } from './services/code-generator.service';
import {
  ChatDto,
  FindFilesDto,
  ReadFileDto,
  WriteFileDto,
  EditFileDto,
} from './dto/chat.dto';
import { GenerateCodeDto, AnalyzeCodeDto, CreateModuleDto } from './dto/generate.dto';
import type { Response } from 'express';

@Controller('mcp')
export class McpController {
  private readonly basePath = process.cwd();

  constructor(
    private readonly mcpService: McpService,
    private readonly fileService: FileService,
    private readonly codeGenerator: CodeGeneratorService,
  ) {}

  /**
   * 聊天接口 - 基础对话
   */
  @Post('chat')
  @HttpCode(HttpStatus.OK)
  async chat(@Body() chatDto: ChatDto) {
    this.assertDevelopmentOnly();
    const { message, system, history } = chatDto;

    const reply = await this.mcpService.chat({
      message,
      system,
      history: history as ChatMessage[],
    });

    return {
      success: true,
      data: {
        reply,
      },
    };
  }

  /**
   * 智能聊天接口 - 支持文件操作工具
   */
  @Post('chat/smart')
  @HttpCode(HttpStatus.OK)
  async smartChat(@Body() chatDto: ChatDto) {
    this.assertDevelopmentOnly();
    const { message, system, history } = chatDto;

    const tools = this.getFileOperationTools();
    const systemPrompt = system || [
      this.mcpService.getSystemPrompt(this.basePath),
      '项目说明文档入口: docs/ai-context/README.md。',
      '处理 QuickAdmin 项目代码任务时，先读取该索引文档，再按需读取真实源码。',
    ].join('\n');

    const reply = await this.mcpService.chatWithTools(
      {
        message,
        system: systemPrompt,
        history: history as ChatMessage[],
      },
      tools,
      async (toolCall) => {
        return this.executeToolCall(toolCall);
      },
    );

    return {
      success: true,
      data: {
        reply,
      },
    };
  }

  @Post('chat/smart/stream')
  @HttpCode(HttpStatus.OK)
  async smartChatStream(@Body() chatDto: ChatDto, @Res() res: Response) {
    this.assertDevelopmentOnly();
    const { message, system, history } = chatDto;

    res.setHeader('Content-Type', 'text/event-stream; charset=utf-8');
    res.setHeader('Cache-Control', 'no-cache, no-transform');
    res.setHeader('Connection', 'keep-alive');
    res.flushHeaders?.();

    const sendEvent = (event: Record<string, any>) => {
      res.write(`data: ${JSON.stringify(event)}\n\n`);
    };

    try {
      const tools = this.getFileOperationTools();
      const systemPrompt = system || [
        this.mcpService.getSystemPrompt(this.basePath),
        '项目说明文档入口: docs/ai-context/README.md。',
        '处理 QuickAdmin 项目代码任务时，先读取该索引文档，再按需读取真实源码。',
      ].join('\n');

      await this.mcpService.chatWithToolsStream(
        {
          message,
          system: systemPrompt,
          history: history as ChatMessage[],
        },
        tools,
        async (toolCall) => {
          return this.executeToolCall(toolCall);
        },
        sendEvent,
      );
    } catch (error) {
      sendEvent({
        type: 'error',
        message: error.message || 'MCP stream failed',
      });
    } finally {
      res.end();
    }
  }

  /**
   * 查找文件接口
   */
  @Get('files')
  async findFiles(@Query() query: FindFilesDto) {
    this.assertDevelopmentOnly();
    const result = await this.fileService.findFiles(
      {
        folder: query.folder,
        extensions: query.extensions,
        recursive: query.recursive,
        maxResults: query.maxResults,
      },
      this.basePath,
    );

    return {
      success: true,
      data: result,
    };
  }

  /**
   * 读取文件接口
   */
  @Get('file')
  async readFile(@Query() query: ReadFileDto) {
    this.assertDevelopmentOnly();
    const result = await this.fileService.readFile(
      {
        path: query.path,
        maxBytes: query.maxBytes,
      },
      this.basePath,
    );

    return {
      success: true,
      data: result,
    };
  }

  /**
   * 写入文件接口
   */
  @Post('file')
  @HttpCode(HttpStatus.OK)
  async writeFile(@Body() body: WriteFileDto) {
    this.assertDevelopmentOnly();
    const result = await this.fileService.writeFile(
      {
        path: body.path,
        content: body.content,
      },
      this.basePath,
    );

    return {
      success: true,
      data: result,
    };
  }

  /**
   * 编辑文件接口
   */
  @Post('file/edit')
  @HttpCode(HttpStatus.OK)
  async editFile(@Body() body: EditFileDto) {
    this.assertDevelopmentOnly();
    const result = await this.fileService.editFile(
      {
        path: body.path,
        oldText: body.oldText,
        newText: body.newText,
      },
      this.basePath,
    );

    return {
      success: true,
      data: result,
    };
  }

  /**
   * 获取文件操作工具定义
   */
  private getFileOperationTools() {
    return [
      {
        type: 'function',
        function: {
          name: 'find_files',
          description:
            'Find files under the current QuickAdmin project sandbox only.',
          parameters: {
            type: 'object',
            properties: {
              folder: {
                type: 'string',
                description:
                  'Folder to scan inside the QuickAdmin project. Use "." or omit for project root. Paths outside the project are rejected.',
              },
              extensions: {
                type: 'array',
                items: { type: 'string' },
                description:
                  'Optional file extensions to match, for example [".png", ".jpg"].',
              },
              recursive: {
                type: 'boolean',
                description: 'Whether to scan subfolders recursively.',
              },
              maxResults: {
                type: 'number',
                description: 'Maximum number of files to return. Default is 200.',
              },
            },
            required: [],
          },
        },
      },
      {
        type: 'function',
        function: {
          name: 'read_file',
          description:
            'Read the text content of a file inside the current QuickAdmin project sandbox.',
          parameters: {
            type: 'object',
            properties: {
              path: {
                type: 'string',
                description: 'Project-relative file path to read. Paths outside the project are rejected.',
              },
              maxBytes: {
                type: 'number',
                description: 'Maximum bytes to read. Default is 80000, maximum is 200000.',
              },
            },
            required: ['path'],
          },
        },
      },
      {
        type: 'function',
        function: {
          name: 'write_file',
          description:
            'Create or overwrite a text file inside the current QuickAdmin project sandbox.',
          parameters: {
            type: 'object',
            properties: {
              path: {
                type: 'string',
                description: 'Project-relative file path to create or overwrite. Paths outside the project are rejected.',
              },
              content: {
                type: 'string',
                description: 'Text content to write into the file.',
              },
            },
            required: ['path', 'content'],
          },
        },
      },
      {
        type: 'function',
        function: {
          name: 'edit_file',
          description:
            'Modify a text file inside the current QuickAdmin project sandbox by replacing one exact text block with another.',
          parameters: {
            type: 'object',
            properties: {
              path: {
                type: 'string',
                description: 'Project-relative file path to edit. Paths outside the project are rejected.',
              },
              oldText: {
                type: 'string',
                description: 'Exact existing text to replace.',
              },
              newText: {
                type: 'string',
                description: 'Replacement text.',
              },
            },
            required: ['path', 'oldText', 'newText'],
          },
        },
      },
  ]
  }

  /**
   * 生成代码接口
   */
  @Post('generate')
  @HttpCode(HttpStatus.OK)
  async generateCode(@Body() generateDto: GenerateCodeDto) {
    this.assertDevelopmentOnly();
    let files;

    switch (generateDto.type) {
      case 'vue_component':
        files = await this.codeGenerator.generateVueComponent({
          name: generateDto.name,
          description: generateDto.description,
          fields: generateDto.fields,
          template: generateDto.template,
        });
        break;

      case 'model':
        files = await this.codeGenerator.generateModel({
          name: generateDto.name,
          fields: generateDto.fields,
          description: generateDto.description,
        });
        break;

      case 'controller':
        files = await this.codeGenerator.generateController({
          name: generateDto.name,
          description: generateDto.description,
        });
        break;

      default:
        return {
          success: false,
          message: '不支持的生成类型',
        };
    }

    // 写入文件
    await this.codeGenerator.writeFiles(files);

    return {
      success: true,
      data: {
        files: files.map(f => ({
          path: f.path,
          type: f.type,
          description: f.description,
        })),
        message: `成功生成 ${files.length} 个文件`,
      },
    };
  }

  /**
   * 分析代码接口
   */
  @Get('analyze')
  async analyzeCode(@Query() query: AnalyzeCodeDto) {
    this.assertDevelopmentOnly();
    const analysis = await this.codeGenerator.analyzeCode(query.path);

    return {
      success: true,
      data: analysis,
    };
  }

  /**
   * 创建完整模块
   */
  @Post('module')
  @HttpCode(HttpStatus.OK)
  async createModule(@Body() moduleDto: CreateModuleDto) {
    this.assertDevelopmentOnly();
    const allFiles: any[] = [];

    // 生成后端代码
    if (moduleDto.targetSide === 'backend' || !moduleDto.targetSide) {
      const modelFiles = await this.codeGenerator.generateModel({
        name: moduleDto.moduleName,
        description: moduleDto.description,
        fields: moduleDto.features,
      });
      const controllerFiles = await this.codeGenerator.generateController({
        name: moduleDto.moduleName,
        description: moduleDto.description,
      });
      allFiles.push(...modelFiles, ...controllerFiles);
    }

    // 生成前端代码
    if (moduleDto.targetSide === 'frontend' || !moduleDto.targetSide) {
      const vueFiles = await this.codeGenerator.generateVueComponent({
        name: moduleDto.moduleName,
        description: moduleDto.description,
        fields: moduleDto.features,
      });
      allFiles.push(...vueFiles);
    }

    // 写入所有文件
    await this.codeGenerator.writeFiles(allFiles);

    return {
      success: true,
      data: {
        files: allFiles.map(f => ({
          path: f.path,
          type: f.type,
          description: f.description,
        })),
        message: `成功创建模块 ${moduleDto.moduleName}，共生成 ${allFiles.length} 个文件`,
      },
    };
  }

  /**
   * 执行工具调用
   */
  private async executeToolCall(toolCall: any): Promise<any> {
    const toolName = toolCall.function?.name;
    const rawArguments = toolCall.function?.arguments || '{}';
    const parsedArguments = JSON.parse(rawArguments);

    switch (toolName) {
      case 'find_files':
        return this.fileService.findFiles(parsedArguments, this.basePath);

      case 'read_file':
        return this.fileService.readFile(parsedArguments, this.basePath);

      case 'write_file':
        return this.fileService.writeFile(parsedArguments, this.basePath);

      case 'edit_file':
        return this.fileService.editFile(parsedArguments, this.basePath);

      default:
        throw new Error(`Unknown tool: ${toolName}`);
    }
  }

  private assertDevelopmentOnly(): void {
    const env = (process.env.ENV || process.env.NODE_ENV || '').trim().toLowerCase();
    if (env !== 'development') {
      throw new ForbiddenException('MCP AI is only available in development environment.');
    }
  }
}
