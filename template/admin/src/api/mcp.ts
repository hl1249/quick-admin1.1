import http from '@/utils/axios'
import { getUrl } from '@/utils/axios'
import { AUTHORIZATION } from '@/config'
import { useStore } from '@/store'

export type AiChatRole = 'user' | 'assistant' | 'system'

export interface AiChatMessage {
  role: AiChatRole
  content: string
}

export interface McpChatPayload {
  message: string
  system?: string
  history?: AiChatMessage[]
}

export function smartChat(data: McpChatPayload) {
  return http.request({
    url: '/mcp/chat/smart',
    method: 'post',
    data,
    openMessage: false,
  })
}

export type McpStreamEvent =
  | { type: 'delta'; content: string }
  | { type: 'progress'; message: string }
  | { type: 'error'; message: string }
  | { type: 'done' }

export async function streamSmartChat(
  data: McpChatPayload,
  onEvent: (event: McpStreamEvent) => void,
) {
  const { authStore } = useStore()
  const response = await fetch(`${getUrl()}/mcp/chat/smart/stream`, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      [AUTHORIZATION]: `Bearer ${authStore.token}`,
    },
    body: JSON.stringify(data),
    credentials: 'include',
  })

  if (!response.ok || !response.body) {
    throw new Error(`MCP 流式请求失败：${response.status}`)
  }

  const reader = response.body.getReader()
  const decoder = new TextDecoder('utf-8')
  let buffer = ''

  while (true) {
    const { value, done } = await reader.read()
    if (done) break

    buffer += decoder.decode(value, { stream: true })
    const parts = buffer.split('\n\n')
    buffer = parts.pop() ?? ''

    for (const part of parts) {
      const line = part
        .split('\n')
        .map(item => item.trim())
        .find(item => item.startsWith('data:'))

      if (!line) continue

      const raw = line.replace(/^data:\s*/, '')
      if (!raw) continue
      onEvent(JSON.parse(raw) as McpStreamEvent)
    }
  }
}
