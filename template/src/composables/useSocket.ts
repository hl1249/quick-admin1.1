import { computed, onBeforeUnmount, ref, shallowRef, watch } from 'vue'
import type { ComputedRef, Ref, ShallowRef } from 'vue'
import { io } from 'socket.io-client'
import type { Socket } from 'socket.io-client'
import { useAuthStore } from '@/store/modules/authStore'

export const SOCKET_NAMESPACES = {
  admin: '/admin',
  client: '/client',
} as const

export const SOCKET_EVENTS = {
  ping: 'ping',
  pong: 'pong',
  roomJoin: 'room:join',
  roomLeave: 'room:leave',
  notify: 'notify',
  orderUpdated: 'order:updated',
  chatSend: 'chat:send',
  chatMessage: 'chat:message',
  cartSync: 'cart:sync',
  exception: 'exception',
} as const

export type SocketNamespaceKey = keyof typeof SOCKET_NAMESPACES

export interface SocketUserInfo {
  _id: string
  username?: string
  nickname?: string
  role?: string[]
  [key: string]: any
}

export interface JoinBizRoomPayload {
  bizType: string
  bizId: string
}

export interface AdminOrderUpdatedPayload {
  orderId: string
  title?: string
  message: string
  level?: 'info' | 'warning' | 'urgent'
  operatorId?: string
  extra?: Record<string, any>
  ts: number
}

export interface SocketNotifyPayload extends Record<string, any> {
  ts?: number
}

export interface SocketPongPayload {
  ts: number
  namespace: SocketNamespaceKey
}

export interface ClientChatPayload extends JoinBizRoomPayload {
  message: string
}

export interface ClientChatMessagePayload extends ClientChatPayload {
  sender: SocketUserInfo
  ts: number
}

export interface ClientCartSyncPayload extends JoinBizRoomPayload {
  cart: Record<string, any>
}

export interface ClientCartSyncMessagePayload extends ClientCartSyncPayload {
  sender: SocketUserInfo
  ts: number
}

export interface SocketExceptionPayload {
  message?: string
  [key: string]: any
}

export interface UseSocketOptions {
  namespace: SocketNamespaceKey
  immediate?: boolean
  timeout?: number
  transports?: Array<'websocket' | 'polling'>
  shared?: boolean
}

export interface UseSocketReturn {
  socket: ShallowRef<Socket | null>
  baseUrl: ComputedRef<string>
  namespacePath: ComputedRef<string>
  namespaceUrl: ComputedRef<string>
  isConnected: Ref<boolean>
  isConnecting: Ref<boolean>
  lastError: Ref<string>
  lastPong: Ref<SocketPongPayload | null>
  connectionId: Ref<string>
  connect: () => Socket | null
  disconnect: () => void
  destroy: () => void
  emitWithAck: <TResult = any, TPayload = undefined>(event: string, payload?: TPayload) => Promise<TResult>
  on: <TPayload = any>(event: string, handler: (payload: TPayload) => void) => () => void
  once: <TPayload = any>(event: string, handler: (payload: TPayload) => void) => () => void
  off: <TPayload = any>(event: string, handler?: (payload: TPayload) => void) => void
  ping: () => Promise<SocketPongPayload>
  joinRoom: (payload: JoinBizRoomPayload) => Promise<{ room: string; joined: boolean }>
  leaveRoom: (payload: JoinBizRoomPayload) => Promise<{ room: string; joined: boolean }>
  sendChat: (payload: ClientChatPayload) => Promise<{ room: string; sent: boolean }>
  syncCart: (payload: ClientCartSyncPayload) => Promise<{ room: string; synced: boolean }>
}

const DEFAULT_TIMEOUT = 10000
const DEFAULT_TRANSPORTS: Array<'websocket' | 'polling'> = ['websocket', 'polling']
const DEFAULT_IMMEDIATE = true

let adminSocketSingleton: UseSocketReturn | null = null

const trimQuotes = (value: string) => value.replace(/^['"]|['"]$/g, '')

const trimTrailingSlash = (value: string) => value.replace(/\/+$/, '')

const stripApiSuffix = (value: string) => value.replace(/\/api\/?$/, '')

const normalizeEnvValue = (value?: string) => {
  if (!value) return ''
  return trimQuotes(value.trim())
}

export const getSocketBaseUrl = () => {
  const socketBaseUrl = normalizeEnvValue(import.meta.env.VITE_SOCKET_BASE_URL as string | undefined)
  if (socketBaseUrl) {
    if (socketBaseUrl === 'getCurrentDomain' || socketBaseUrl.startsWith('/')) {
      return window.location.origin
    }
    return trimTrailingSlash(socketBaseUrl)
  }

  const axiosBaseUrl = normalizeEnvValue(import.meta.env.VITE_AXIOS_BASE_URL as string | undefined)
  if (!axiosBaseUrl || axiosBaseUrl === 'getCurrentDomain' || axiosBaseUrl.startsWith('/')) {
    return window.location.origin
  }

  return trimTrailingSlash(stripApiSuffix(axiosBaseUrl))
}

const getSocketUrl = (namespace: SocketNamespaceKey) =>
  `${getSocketBaseUrl()}${SOCKET_NAMESPACES[namespace]}`

const toBearerToken = (token?: string) => {
  const value = token?.trim()
  if (!value) return ''
  return value.startsWith('Bearer ') ? value : `Bearer ${value}`
}

export function useSocket(options: UseSocketOptions): UseSocketReturn {
  const authStore = useAuthStore()
  const shouldAutoConnect = options.immediate ?? DEFAULT_IMMEDIATE
  const isSharedInstance = options.shared ?? false
  const socket = shallowRef<Socket | null>(null)
  const isConnected = ref(false)
  const isConnecting = ref(false)
  const lastError = ref('')
  const lastPong = ref<SocketPongPayload | null>(null)
  const connectionId = ref('')
  const baseUrl = computed(() => getSocketBaseUrl())
  const namespacePath = computed(() => SOCKET_NAMESPACES[options.namespace])
  const namespaceUrl = computed(() => getSocketUrl(options.namespace))
  const timeout = options.timeout ?? DEFAULT_TIMEOUT

  const handleConnect = () => {
    isConnected.value = true
    isConnecting.value = false
    lastError.value = ''
    connectionId.value = socket.value?.id ?? ''
  }

  const handleDisconnect = () => {
    isConnected.value = false
    isConnecting.value = false
    connectionId.value = ''
  }

  const handleConnectError = (error: Error) => {
    isConnected.value = false
    isConnecting.value = false
    lastError.value = error.message || 'Socket 连接失败'
  }

  const handleException = (payload: SocketExceptionPayload) => {
    lastError.value = payload?.message || 'Socket 连接异常'
  }

  const handlePong = (payload: SocketPongPayload) => {
    lastPong.value = payload
  }

  const bindCoreListeners = (client: Socket) => {
    client.on('connect', handleConnect)
    client.on('disconnect', handleDisconnect)
    client.on('connect_error', handleConnectError)
    client.on(SOCKET_EVENTS.exception, handleException)
    client.on(SOCKET_EVENTS.pong, handlePong)
  }

  const unbindCoreListeners = (client: Socket) => {
    client.off('connect', handleConnect)
    client.off('disconnect', handleDisconnect)
    client.off('connect_error', handleConnectError)
    client.off(SOCKET_EVENTS.exception, handleException)
    client.off(SOCKET_EVENTS.pong, handlePong)
  }

  const ensureSocket = () => {
    if (socket.value) return socket.value

    const client = io(namespaceUrl.value, {
      autoConnect: false,
      withCredentials: true,
      transports: options.transports ?? DEFAULT_TRANSPORTS,
      auth: {
        token: toBearerToken(authStore.token),
      },
    })

    bindCoreListeners(client)
    socket.value = client
    return client
  }

  const updateAuth = (client: Socket) => {
    client.auth = {
      token: toBearerToken(authStore.token),
    }
  }

  const connect = () => {
    if (!authStore.token) {
      lastError.value = '当前未登录，无法建立 Socket 连接'
      return null
    }

    const client = ensureSocket()
    updateAuth(client)

    if (!client.connected) {
      isConnecting.value = true
      client.connect()
    }

    return client
  }

  const disconnect = () => {
    if (!socket.value) return
    socket.value.disconnect()
  }

  const destroy = () => {
    if (!socket.value) return

    unbindCoreListeners(socket.value)
    socket.value.disconnect()
    socket.value = null
    isConnected.value = false
    isConnecting.value = false
    connectionId.value = ''
  }

  const emitWithAck = <TResult = any, TPayload = undefined>(event: string, payload?: TPayload) => {
    const client = connect()
    if (!client) {
      return Promise.reject(new Error('当前未登录，无法发送 Socket 事件'))
    }

    updateAuth(client)

    return new Promise<TResult>((resolve, reject) => {
      const callback = (error: Error | null, response: TResult) => {
        if (error) {
          reject(error)
          return
        }
        resolve(response)
      }

      if (typeof payload === 'undefined') {
        client.timeout(timeout).emit(event, callback)
        return
      }

      client.timeout(timeout).emit(event, payload, callback)
    })
  }

  const on = <TPayload = any>(event: string, handler: (payload: TPayload) => void) => {
    const client = ensureSocket()
    client.on(event, handler as (...args: any[]) => void)
    return () => client.off(event, handler as (...args: any[]) => void)
  }

  const once = <TPayload = any>(event: string, handler: (payload: TPayload) => void) => {
    const client = ensureSocket()
    client.once(event, handler as (...args: any[]) => void)
    return () => client.off(event, handler as (...args: any[]) => void)
  }

  const off = <TPayload = any>(event: string, handler?: (payload: TPayload) => void) => {
    if (!socket.value) return
    if (handler) {
      socket.value.off(event, handler as (...args: any[]) => void)
      return
    }
    socket.value.off(event)
  }

  const ping = () => emitWithAck<SocketPongPayload>(SOCKET_EVENTS.ping)

  const joinRoom = (payload: JoinBizRoomPayload) =>
    emitWithAck<{ room: string; joined: boolean }, JoinBizRoomPayload>(SOCKET_EVENTS.roomJoin, payload)

  const leaveRoom = (payload: JoinBizRoomPayload) =>
    emitWithAck<{ room: string; joined: boolean }, JoinBizRoomPayload>(SOCKET_EVENTS.roomLeave, payload)

  const sendChat = (payload: ClientChatPayload) =>
    emitWithAck<{ room: string; sent: boolean }, ClientChatPayload>(SOCKET_EVENTS.chatSend, payload)

  const syncCart = (payload: ClientCartSyncPayload) =>
    emitWithAck<{ room: string; synced: boolean }, ClientCartSyncPayload>(SOCKET_EVENTS.cartSync, payload)

  watch(
    () => authStore.token,
    token => {
      if (!token) {
        destroy()
        lastError.value = ''
        return
      }

      if (!shouldAutoConnect) {
        if (socket.value) {
          updateAuth(socket.value)
        }
        return
      }

      if (!socket.value) {
        connect()
        return
      }

      updateAuth(socket.value)

      if (!socket.value.connected) {
        connect()
      }
    },
    { immediate: shouldAutoConnect },
  )

  onBeforeUnmount(() => {
    if (!isSharedInstance) {
      destroy()
    }
  })

  return {
    socket,
    baseUrl,
    namespacePath,
    namespaceUrl,
    isConnected,
    isConnecting,
    lastError,
    lastPong,
    connectionId,
    connect,
    disconnect,
    destroy,
    emitWithAck,
    on,
    once,
    off,
    ping,
    joinRoom,
    leaveRoom,
    sendChat,
    syncCart,
  }
}

const getAdminSharedSocket = (
  options: Omit<UseSocketOptions, 'namespace'> = {},
): UseSocketReturn => {
  if (adminSocketSingleton) {
    if (options.immediate !== false) {
      adminSocketSingleton.connect()
    }
    return adminSocketSingleton
  }

  adminSocketSingleton = useSocket({
    namespace: 'admin',
    immediate: options.immediate ?? DEFAULT_IMMEDIATE,
    timeout: options.timeout,
    transports: options.transports,
    shared: true,
  })

  return adminSocketSingleton
}

export const useAdminSocket = (
  options: Omit<UseSocketOptions, 'namespace'> = {},
): UseSocketReturn =>
  getAdminSharedSocket(options)
