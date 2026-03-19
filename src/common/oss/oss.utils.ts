import { extname } from 'path';
import { randomUUID } from 'crypto';

const trimSlash = (v: string) => v.replace(/^\/+|\/+$/g, '');

export const buildObjectKey = (folder = '', filename?: string) => {
  const safeFolder = trimSlash(folder);
  const ext = filename ? extname(filename) : '';
  const objectName = `${Date.now()}-${randomUUID().replace(/-/g, '')}${ext}`;
  return safeFolder ? `${safeFolder}/${objectName}` : objectName;
};

export const joinUrl = (base: string, key: string) => {
  if (!base) return key;
  return `${base.replace(/\/+$/, '')}/${key.replace(/^\/+/, '')}`;
};

export const ensureRequired = (name: string, value: string) => {
  if (!value) {
    throw new Error(`OSS 配置缺失: ${name}`);
  }
};
