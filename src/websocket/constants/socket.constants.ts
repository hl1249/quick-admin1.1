export const SOCKET_NAMESPACES = {
  admin: '/admin',
  client: '/client',
} as const;

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
} as const;

// 根据用户 ID 生成用户专属房间名，用于单播消息推送。
export const buildUserRoom = (userId: string) => `user:${userId}`;

// 根据业务类型和业务 ID 生成标准业务房间名，用于分组广播。
export const buildBizRoom = (bizType: string, bizId: string) =>
  `biz:${bizType}:${bizId}`;
