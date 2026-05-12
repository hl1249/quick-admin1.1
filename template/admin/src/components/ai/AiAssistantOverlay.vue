<template>
  <Teleport to="body">
    <Transition name="qa-ai-fade">
      <div v-if="visible" class="qa-ai-mask" @click.self="close">
        <section class="qa-ai-panel">
          <header class="qa-ai-header">
            <div>
              <h1 class="qa-ai-title">AI</h1>
              <div class="qa-ai-context">{{ routeLabel }}</div>
            </div>
            <div class="qa-ai-actions">
              <el-tooltip content="Alt + R">
                <el-tag size="small" effect="plain">Alt+R</el-tag>
              </el-tooltip>
              <el-button circle :icon="Close" @click="close" />
            </div>
          </header>

          <div class="qa-ai-body">
            <aside class="qa-ai-side">
              <div class="qa-ai-side-title">当前页面</div>
              <dl>
                <dt>路由</dt>
                <dd>{{ currentRoute.path }}</dd>
                <dt>页面文件</dt>
                <dd>{{ currentComponentPath || '未匹配到菜单组件路径' }}</dd>
              </dl>
              <div class="qa-ai-context-meter" :class="`is-${contextUsage.level}`">
                <div class="qa-ai-context-meter-head">
                  <span>上下文</span>
                  <strong>{{ contextUsage.percent }}%</strong>
                </div>
                <div class="qa-ai-context-meter-track">
                  <i :style="{ width: `${contextUsage.percent}%` }"></i>
                </div>
                <div class="qa-ai-context-meter-meta">
                  {{ formatTokenCount(contextUsage.used) }} / {{ formatTokenCount(contextUsage.limit) }} tokens
                </div>
              </div>
              <el-button class="w-full" :icon="Refresh" @click="resetChat">新会话</el-button>
            </aside>

            <main class="qa-ai-chat">
              <div ref="messageBoxRef" class="qa-ai-messages">
                <div
                  v-for="(item, index) in messages"
                  :key="index"
                  class="qa-ai-message"
                  :class="`is-${item.role}`"
                >
                  <div class="qa-ai-message-role">
                    {{ item.role === 'user' ? '你' : 'AI' }}
                  </div>
                  <pre>{{ item.content }}</pre>
                </div>
                <div v-if="chatLoading" class="qa-ai-message is-assistant is-thinking">
                  <div class="qa-ai-message-role">AI</div>
                  <div v-if="toolStatus" class="qa-ai-tool-status">
                    <span></span>
                    {{ toolStatus }}...
                  </div>
                  <div v-else class="qa-ai-thinking" aria-label="AI 正在思考">
                    <span></span>
                    <span></span>
                    <span></span>
                  </div>
                </div>
              </div>

              <div class="qa-ai-composer">
                <el-input
                  v-model="draft"
                  type="textarea"
                  :autosize="{ minRows: 3, maxRows: 7 }"
                  resize="none"
                  placeholder="告诉 AI 你想怎样调整当前页面"
                  @keydown.enter.exact.prevent="send"
                />
                <div class="qa-ai-composer-footer">
                  <el-button plain :icon="Document" @click="fillRewritePrompt">
                    当前页面
                  </el-button>
                  <el-button type="primary" :loading="chatLoading" :icon="Promotion" @click="send">
                    发送
                  </el-button>
                </div>
              </div>
            </main>
          </div>
        </section>
      </div>
    </Transition>
  </Teleport>
</template>

<script setup lang="ts">
import { computed, nextTick, onBeforeUnmount, onMounted, ref } from 'vue'
import { useRoute } from 'vue-router'
import {
  Close,
  Document,
  Promotion,
  Refresh,
} from '@element-plus/icons-vue'
import { streamSmartChat, type AiChatMessage } from '@/api/mcp'
import { useStore } from '@/store'

const visible = ref(false)
const draft = ref('')
const chatLoading = ref(false)
const toolStatus = ref('')
const messageBoxRef = ref<HTMLElement>()
const currentRoute = useRoute()
const { menuStore } = useStore()
const CONTEXT_TOKEN_LIMIT = 64000

const messages = ref<AiChatMessage[]>([
  {
    role: 'assistant',
    content:
      '我已经拿到当前路由和页面文件。你可以直接告诉我想怎样调整当前页面。',
  },
])

const routeLabel = computed(() => {
  const title = currentRoute.meta?.title ? String(currentRoute.meta.title) : '当前页面'
  return `${title} · ${currentRoute.path}`
})

const currentComponentPath = computed(() => {
  const matched = findMenuByPath(menuStore.menuList, currentRoute.path)
  const component = matched?.component
  if (typeof component === 'string') {
    return component.endsWith('.vue') ? component : `${component}.vue`
  }
  if (currentRoute.path === '/home') return '/src/pages/home/index.vue'
  return `/src/pages${currentRoute.path}/index.vue`
})

const contextUsage = computed(() => {
  const content = [
    buildSystemPrompt(),
    ...messages.value.map(item => `${item.role}: ${item.content}`),
    draft.value ? `draft: ${draft.value}` : '',
  ].join('\n')
  const used = estimateTokenCount(content)
  const percent = Math.min(100, Math.round((used / CONTEXT_TOKEN_LIMIT) * 100))
  const level = percent >= 90 ? 'danger' : percent >= 70 ? 'warning' : 'normal'

  return {
    used,
    limit: CONTEXT_TOKEN_LIMIT,
    percent,
    level,
  }
})

function findMenuByPath(list: any[], routePath: string): any | null {
  for (const item of list || []) {
    const itemPath = `/${String(item.path || '').replace(/^\/+/, '')}`
    if (itemPath === routePath) return item
    const child = findMenuByPath(item.children || [], routePath)
    if (child) return child
  }
  return null
}

function open() {
  visible.value = true
  nextTick(scrollToBottom)
}

function close() {
  visible.value = false
}

function toggle() {
  visible.value ? close() : open()
}

function handleKeydown(event: KeyboardEvent) {
  if (event.altKey && event.key.toLowerCase() === 'r') {
    event.preventDefault()
    toggle()
  }
}

function resetChat() {
  messages.value = messages.value.slice(0, 1)
  draft.value = ''
}

function buildSystemPrompt() {
  return [
    '你是 QuickAdmin 后台内置 AI 助手，回答使用中文。',
    '你可以通过 MCP 文件工具读取、修改当前项目文件；修改文件前先读取真实内容，再给出清晰说明。',
    '项目说明文档入口: docs/ai-context/README.md。',
    '如果用户要求分析、改写或创建项目代码，请先读取 docs/ai-context/README.md，再按需读取对应说明文档和真实源码。',
    `当前路由: ${currentRoute.path}`,
    `当前页面组件: ${currentComponentPath.value}`,
    '当前用户重点关注这个路由页面的对话、分析和改写。',
  ].join('\n')
}

function fillRewritePrompt() {
  draft.value = `请读取并改写当前页面组件：${currentComponentPath.value}\n需求：`
}

function extractReply(payload: any): string {
  return (
    payload?.data?.data?.data?.reply ||
    payload?.data?.data?.reply ||
    payload?.data?.reply ||
    payload?.reply ||
    'AI 没有返回内容'
  )
}

function estimateTokenCount(value: string) {
  let cjk = 0
  let other = 0

  for (const char of value) {
    if (/[\u4e00-\u9fff\u3400-\u4dbf\uff00-\uffef]/.test(char)) {
      cjk += 1
    } else if (!/\s/.test(char)) {
      other += 1
    }
  }

  return Math.ceil(cjk + other / 4)
}

function formatTokenCount(value: number) {
  if (value >= 1000) return `${(value / 1000).toFixed(value >= 10000 ? 0 : 1)}k`
  return String(value)
}

async function send() {
  const content = draft.value.trim()
  if (!content || chatLoading.value) return

  const history = messages.value.filter(item => item.role === 'user' || item.role === 'assistant')
  messages.value.push({ role: 'user', content })
  const assistantMessage: AiChatMessage = { role: 'assistant', content: '' }
  messages.value.push(assistantMessage)
  draft.value = ''
  chatLoading.value = true
  toolStatus.value = ''
  await nextTick(scrollToBottom)

  try {
    await streamSmartChat(
      {
        message: content,
        system: buildSystemPrompt(),
        history,
      },
      async event => {
        if (event.type === 'delta') {
          toolStatus.value = ''
          assistantMessage.content += event.content
          await nextTick(scrollToBottom)
        }

        if (event.type === 'progress') {
          toolStatus.value = event.message
          await nextTick(scrollToBottom)
        }

        if (event.type === 'error') {
          assistantMessage.content += `\n${event.message}`
        }
      },
    )

    if (!assistantMessage.content.trim()) {
      assistantMessage.content = '操作已完成。'
    }
  } catch (error: any) {
    assistantMessage.content =
      error?.response?.data?.message || error?.message || '请求 MCP 失败'
  } finally {
    chatLoading.value = false
    toolStatus.value = ''
    await nextTick(scrollToBottom)
  }
}

function scrollToBottom() {
  if (!messageBoxRef.value) return
  messageBoxRef.value.scrollTop = messageBoxRef.value.scrollHeight
}

onMounted(() => {
  window.addEventListener('keydown', handleKeydown)
})

onBeforeUnmount(() => {
  window.removeEventListener('keydown', handleKeydown)
})
</script>

<style scoped>
.qa-ai-mask {
  position: fixed;
  inset: 0;
  z-index: 4000;
  display: flex;
  justify-content: flex-end;
  background: rgba(15, 23, 42, 0.38);
  backdrop-filter: blur(3px);
}

.qa-ai-panel {
  width: min(1120px, calc(100vw - 32px));
  height: calc(100vh - 32px);
  margin: 16px;
  display: flex;
  flex-direction: column;
  overflow: hidden;
  background: #f8fafc;
  border: 1px solid #d7dee8;
  border-radius: 8px;
  box-shadow: 0 24px 70px rgba(15, 23, 42, 0.22);
}

.qa-ai-header {
  height: 64px;
  flex: 0 0 auto;
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 0 18px;
  color: #172033;
  background: #ffffff;
  border-bottom: 1px solid #e4e8f0;
}

.qa-ai-title {
  font-size: 18px;
  font-weight: 700;
}

.qa-ai-context {
  margin-top: 4px;
  font-size: 12px;
  color: #667085;
}

.qa-ai-actions {
  display: flex;
  align-items: center;
  gap: 8px;
}

.qa-ai-body {
  flex: 1;
  height: 100%;
  display: grid;
  grid-template-columns: 280px minmax(0, 1fr);
  min-height: 0;
}

.qa-ai-side {
  padding: 16px;
  border-right: 1px solid #e4e8f0;
  background: #f1f5f9;
}

.qa-ai-side-title {
  margin-bottom: 12px;
  font-weight: 700;
  color: #172033;
}

.qa-ai-side dl {
  margin: 0 0 18px;
}

.qa-ai-side dt {
  margin-top: 12px;
  font-size: 12px;
  color: #667085;
}

.qa-ai-side dd {
  margin: 4px 0 0;
  overflow-wrap: anywhere;
  font-size: 13px;
  color: #25324a;
}

.qa-ai-context-meter {
  margin: 16px 0;
  padding: 12px;
  background: #ffffff;
  border: 1px solid #dfe6ef;
  border-radius: 8px;
}

.qa-ai-context-meter-head {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: 8px;
  font-size: 12px;
  color: #475467;
}

.qa-ai-context-meter-head strong {
  font-size: 12px;
  color: #172033;
}

.qa-ai-context-meter-track {
  height: 8px;
  overflow: hidden;
  background: #edf2f7;
  border-radius: 999px;
}

.qa-ai-context-meter-track i {
  display: block;
  height: 100%;
  min-width: 3px;
  background: #2f80ed;
  border-radius: inherit;
  transition: width 0.2s ease, background-color 0.2s ease;
}

.qa-ai-context-meter.is-warning .qa-ai-context-meter-track i {
  background: #f59e0b;
}

.qa-ai-context-meter.is-danger .qa-ai-context-meter-track i {
  background: #ef4444;
}

.qa-ai-context-meter-meta {
  margin-top: 8px;
  font-size: 12px;
  color: #667085;
}

.qa-ai-chat {
  min-width: 0;
  min-height: 0;
  display: flex;
  flex-direction: column;
}

.qa-ai-messages {
  flex: 1;
  min-height: 0;
  overflow: auto;
  padding: 18px;
}

.qa-ai-message {
  max-width: 82%;
  margin-bottom: 14px;
}

.qa-ai-message.is-user {
  margin-left: auto;
}

.qa-ai-message-role {
  margin-bottom: 6px;
  font-size: 12px;
  color: #667085;
}

.qa-ai-message pre {
  margin: 0;
  padding: 12px 14px;
  white-space: pre-wrap;
  overflow-wrap: anywhere;
  font-family: inherit;
  line-height: 1.65;
  color: #172033;
  background: #ffffff;
  border: 1px solid #dfe6ef;
  border-radius: 8px;
}

.qa-ai-message.is-user pre {
  color: #062b2d;
  background: #d8f3ee;
  border-color: #9ed8cf;
}

.qa-ai-thinking {
  width: fit-content;
  min-width: 64px;
  height: 40px;
  display: flex;
  align-items: center;
  gap: 6px;
  padding: 0 14px;
  background: #ffffff;
  border: 1px solid #dfe6ef;
  border-radius: 8px;
}

.qa-ai-thinking span {
  width: 7px;
  height: 7px;
  border-radius: 50%;
  background: #64748b;
  animation: qa-ai-thinking-dot 1s ease-in-out infinite;
}

.qa-ai-thinking span:nth-child(2) {
  animation-delay: 0.14s;
}

.qa-ai-thinking span:nth-child(3) {
  animation-delay: 0.28s;
}

.qa-ai-tool-status {
  width: fit-content;
  max-width: min(520px, 100%);
  min-height: 40px;
  display: flex;
  align-items: center;
  gap: 8px;
  padding: 9px 14px;
  overflow-wrap: anywhere;
  line-height: 1.5;
  color: #25324a;
  background: #fff8eb;
  border: 1px solid #f4d39c;
  border-radius: 8px;
}

.qa-ai-tool-status span {
  width: 14px;
  height: 14px;
  flex: 0 0 auto;
  border: 2px solid #f59e0b;
  border-top-color: transparent;
  border-radius: 50%;
  animation: qa-ai-tool-spin 0.8s linear infinite;
}

@keyframes qa-ai-tool-spin {
  to {
    transform: rotate(360deg);
  }
}

@keyframes qa-ai-thinking-dot {
  0%,
  80%,
  100% {
    opacity: 0.36;
    transform: translateY(0);
  }

  40% {
    opacity: 1;
    transform: translateY(-5px);
  }
}

.qa-ai-composer {
  padding: 14px 18px 18px;
  background: #ffffff;
  border-top: 1px solid #e4e8f0;
}

.qa-ai-composer-footer {
  display: flex;
  justify-content: flex-end;
  gap: 8px;
  margin-top: 10px;
}

.w-full {
  width: 100%;
}

.qa-ai-fade-enter-active,
.qa-ai-fade-leave-active {
  transition: opacity 0.18s ease;
}

.qa-ai-fade-enter-from,
.qa-ai-fade-leave-to {
  opacity: 0;
}

@media (max-width: 820px) {
  .qa-ai-panel {
    width: 100vw;
    height: 100vh;
    margin: 0;
    border-radius: 0;
  }

  .qa-ai-body {
    grid-template-columns: 1fr;
  }

  .qa-ai-side {
    display: none;
  }

  .qa-ai-message {
    max-width: 94%;
  }

  .qa-ai-composer-footer {
    flex-wrap: wrap;
  }
}
</style>
