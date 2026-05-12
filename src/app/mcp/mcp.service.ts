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

export type McpStreamEvent =
  | { type: 'delta'; content: string }
  | { type: 'progress'; message: string }
  | { type: 'error'; message: string }
  | { type: 'done' };

@Injectable()
export class McpService {
  private readonly apiUrl: string;
  private readonly model: string;
  private readonly apiKey: string;
  private readonly maxToolSteps = 12;

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

    for (let step = 0; step < this.maxToolSteps; step++) {
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

    return `工具调用次数已达到 ${this.maxToolSteps} 轮。请把要修改的页面、文件路径或目标描述得更具体一些，我可以继续处理。`;
  }

  async chatWithToolsStream(
    options: ChatOptions,
    tools: any[],
    toolExecutor: (toolCall: ToolCall) => Promise<any>,
    onEvent: (event: McpStreamEvent) => void,
  ): Promise<void> {
    const { message, system, history = [] } = options;

    if (!this.apiKey) {
      throw new Error('Missing DEEPSEEK_API_KEY environment variable.');
    }

    const messages: any[] = [
      ...(system ? [{ role: 'system', content: system }] : []),
      ...history,
      { role: 'user', content: message },
    ];

    for (let step = 0; step < this.maxToolSteps; step++) {
      const responseMessage = await this.streamCompletion(messages, tools, onEvent);
      const toolCalls = responseMessage.tool_calls ?? [];

      if (!toolCalls.length) {
        onEvent({ type: 'done' });
        return;
      }

      messages.push(responseMessage);

      for (const toolCall of toolCalls) {
        onEvent({
          type: 'progress',
          message: this.getToolProgressMessage(toolCall),
        });

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
    }

    onEvent({
      type: 'delta',
      content: `\n\n工具调用次数已达到 ${this.maxToolSteps} 轮。请把要修改的页面、文件路径或目标描述得更具体一些，我可以继续处理。`,
    });
    onEvent({ type: 'done' });
  }

  private async streamCompletion(
    messages: any[],
    tools: any[],
    onEvent: (event: McpStreamEvent) => void,
  ): Promise<any> {
    try {
      const response = await axios.post(
        this.apiUrl,
        {
          model: this.model,
          messages,
          tools,
          tool_choice: 'auto',
          stream: true,
        },
        {
          headers: {
            Authorization: `Bearer ${this.apiKey}`,
            'Content-Type': 'application/json',
          },
          responseType: 'stream',
          timeout: 120000,
        },
      );

      return await new Promise<any>((resolve, reject) => {
        let buffer = '';
        const assistantMessage: any = {
          role: 'assistant',
          content: '',
        };
        const toolCallMap = new Map<number, any>();

        response.data.on('data', (chunk: Buffer) => {
          buffer += chunk.toString('utf8');
          const parts = buffer.split('\n\n');
          buffer = parts.pop() ?? '';

          for (const part of parts) {
            const lines = part
              .split('\n')
              .map(line => line.trim())
              .filter(line => line.startsWith('data:'));

            for (const line of lines) {
              const raw = line.replace(/^data:\s*/, '');
              if (!raw || raw === '[DONE]') continue;

              try {
                const payload = JSON.parse(raw);
                const delta = payload?.choices?.[0]?.delta;
                if (!delta) continue;

                if (delta.content) {
                  assistantMessage.content += delta.content;
                  onEvent({ type: 'delta', content: delta.content });
                }

                if (Array.isArray(delta.tool_calls)) {
                  for (const toolDelta of delta.tool_calls) {
                    const index = Number(toolDelta.index ?? 0);
                    const current = toolCallMap.get(index) ?? {
                      id: '',
                      type: 'function',
                      function: {
                        name: '',
                        arguments: '',
                      },
                    };

                    if (toolDelta.id) current.id = toolDelta.id;
                    if (toolDelta.type) current.type = toolDelta.type;
                    if (toolDelta.function?.name) {
                      current.function.name += toolDelta.function.name;
                    }
                    if (toolDelta.function?.arguments) {
                      current.function.arguments += toolDelta.function.arguments;
                    }

                    toolCallMap.set(index, current);
                  }
                }
              } catch (error) {
                reject(error);
              }
            }
          }
        });

        response.data.on('end', () => {
          const toolCalls = Array.from(toolCallMap.values());
          if (toolCalls.length) {
            assistantMessage.tool_calls = toolCalls;
          }
          resolve(assistantMessage);
        });

        response.data.on('error', reject);
      });
    } catch (error) {
      const detail = error.response?.data
        ? JSON.stringify(error.response.data)
        : error.message;
      throw new Error(`DeepSeek stream request failed: ${detail}`);
    }
  }

  private getToolProgressMessage(toolCall: ToolCall): string {
    const toolName = toolCall.function?.name;
    const rawArguments = toolCall.function?.arguments || '{}';
    let args: Record<string, any> = {};

    try {
      args = JSON.parse(rawArguments);
    } catch {
      args = {};
    }

    const target = args.path || args.folder || '项目文件';
    const actionMap: Record<string, string> = {
      find_files: '正在查找文件',
      read_file: '正在读取文件',
      write_file: '正在写入文件',
      edit_file: '正在修改文件',
    };

    return `${actionMap[toolName] || '正在操作文件'}：${target}`;
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
