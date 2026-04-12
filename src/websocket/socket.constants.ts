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

export const buildUserRoom = (userId: string) => `user:${userId}`;

export const buildBizRoom = (bizType: string, bizId: string) =>
  `biz:${bizType}:${bizId}`;
