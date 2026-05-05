import { Injectable } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import axios from 'axios';

export interface ChatMessage {
  role: 'user' | 'assistant' | 'system';
  content: string;
}

export interface ChatOptions {
  message: string;
  system?: string;
  history?: ChatMessage[];
}

export interface ToolCall {
  id: string;
  type: 'function';
  function: {
    name: string;
    arguments: string;
  };
}

@Injectable()
export class McpService {
  private readonly apiUrl: string;
  private readonly model: string;
  private readonly apiKey: string;

  constructor(private configService: ConfigService) {
    this.apiUrl = this.configService.get<string>(
      'DEEPSEEK_API_URL',
      'https://api.deepseek.com/chat/completions',
    )!;
    this.model = this.configService.get<string>('DEEPSEEK_MODEL', 'deepseek-chat')!;
    this.apiKey = this.configService.get<string>('DEEPSEEK_API_KEY') || '';
  }

  /**
   * 发送聊天消息到 DeepSeek
   */
  async chat(options: ChatOptions): Promise<string> {
    const { message, system, history = [] } = options;

    if (!this.apiKey) {
      throw new Error('Missing DEEPSEEK_API_KEY environment variable.');
    }

    const messages: ChatMessage[] = [
      ...(system ? [{ role: 'system' as const, content: system }] : []),
      ...history,
      { role: 'user', content: message },
    ];

    try {
      const response = await axios.post(
        this.apiUrl,
        {
          model: this.model,
          messages,
          stream: false,
        },
        {
          headers: {
            Authorization: `Bearer ${this.apiKey}`,
            'Content-Type': 'application/json',
          },
          timeout: 60000,
        },
      );

      const reply =
        response.data?.choices?.[0]?.message?.content ??
        'DeepSeek returned an empty response.';

      return reply;
    } catch (error) {
      const detail = error.response?.data
        ? JSON.stringify(error.response.data)
        : error.message;
      throw new Error(`DeepSeek request failed: ${detail}`);
    }
  }

  /**
   * 发送聊天消息并支持工具调用
   */
  async chatWithTools(
    options: ChatOptions,
    tools: any[],
    toolExecutor: (toolCall: ToolCall) => Promise<any>,
  ): Promise<string> {
    const { message, system, history = [] } = options;

    if (!this.apiKey) {
      throw new Error('Missing DEEPSEEK_API_KEY environment variable.');
    }

    const messages: any[] = [
      ...(system ? [{ role: 'system', content: system }] : []),
      ...history,
      { role: 'user', content: message },
    ];

    for (let step = 0; step < 5; step++) {
      try {
        const response = await axios.post(
          this.apiUrl,
          {
            model: this.model,
            messages,
            tools,
            tool_choice: 'auto',
            stream: false,
          },
          {
            headers: {
              Authorization: `Bearer ${this.apiKey}`,
              'Content-Type': 'application/json',
            },
            timeout: 60000,
          },
        );

        const responseMessage = response.data?.choices?.[0]?.message;
        if (!responseMessage) {
          return 'DeepSeek returned an empty response.';
        }

        const toolCalls = responseMessage.tool_calls ?? [];
        if (!toolCalls.length) {
          return responseMessage.content ?? 'DeepSeek returned an empty response.';
        }

        messages.push(responseMessage);

        for (const toolCall of toolCalls) {
          try {
            const toolResult = await toolExecutor(toolCall);
            messages.push({
              role: 'tool',
              tool_call_id: toolCall.id,
              content: JSON.stringify(toolResult),
            });
          } catch (error) {
            messages.push({
              role: 'tool',
              tool_call_id: toolCall.id,
              content: JSON.stringify({ error: error.message }),
            });
          }
        }
      } catch (error) {
        const detail = error.response?.data
          ? JSON.stringify(error.response.data)
          : error.message;
        throw new Error(`DeepSeek request failed: ${detail}`);
      }
    }

    return '工具调用次数过多，已停止。请把问题问得更具体一些。';
  }

  /**
   * 获取系统提示词
   */
  getSystemPrompt(basePath: string): string {
    return `你是一个自然对话的 DeepSeek 中文助手，回答清晰、友好、实用。
你可以使用本地工具扫描文件、读取文件内容、创建文件、修改文件。用户说"桌面"时，指的是 ${basePath}。
你可以访问本机任意可访问路径；用户提供绝对路径时，必须直接使用该绝对路径。
如果用户询问本地文件、文件夹、图片、代码等，不要猜测，先调用工具获取真实结果。
用户问"有哪些文件"时列出全部文件；只有用户明确问图片时，才用图片扩展名过滤。
如果扫描结果很多，不要默认逐项列出所有文件；先按目录、类型或用途汇总，并最多展示 20 个代表性文件。只有用户明确要求"完整列出"时才完整列出。
写入或修改文件前，优先确认目标路径；不要修改 .env、密钥、证书等敏感文件。`;
  }
}
