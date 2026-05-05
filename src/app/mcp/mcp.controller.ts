import {
  Controller,
  Post,
  Body,
  HttpCode,
  HttpStatus,
  Get,
  Query,
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

@Controller('mcp')
export class McpController {
  private readonly basePath = 'E:\\360MoveData\\Users\\Administrator\\Desktop';

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
    const { message, system, history } = chatDto;

    const tools = this.getFileOperationTools();
    const systemPrompt = system || this.mcpService.getSystemPrompt(this.basePath);

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

  /**
   * 查找文件接口
   */
  @Get('files')
  async findFiles(@Query() query: FindFilesDto) {
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
            'Find files under a local folder. Use this for questions about local files, desktop files, or image files.',
          parameters: {
            type: 'object',
            properties: {
              folder: {
                type: 'string',
                description:
                  'Folder to scan. Use "desktop" for the user desktop. Absolute paths are used directly.',
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
            'Read the text content of a local file. Use this when the user asks to view or inspect a file.',
          parameters: {
            type: 'object',
            properties: {
              path: {
                type: 'string',
                description: 'File path to read.',
              },
              maxBytes: {
                type: 'number',
                description: 'Maximum bytes to read. Default is 20000.',
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
            'Create or overwrite a local text file. Parent folders are created automatically.',
          parameters: {
            type: 'object',
            properties: {
              path: {
                type: 'string',
                description: 'File path to create or overwrite.',
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
            'Modify a local text file by replacing one exact text block with another.',
          parameters: {
            type: 'object',
            properties: {
              path: {
                type: 'string',
                description: 'File path to edit.',
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
}
