import type { PiniaPluginContext } from "pinia";

export interface PersistOptions {
  /** 持久化的 key，默认为 store.$id */
  key?: string;
  /** 要持久化的字段，不填则持久化整个 state */
  paths?: string[];
}

declare module "pinia" {
  export interface DefineStoreOptionsBase<S, Store> {
    persist?: boolean | PersistOptions;
  }
}

function pick<T extends object>(obj: T, paths: string[]): Partial<T> {
  return paths.reduce(
    (acc, path) => {
      if (Object.prototype.hasOwnProperty.call(obj, path)) {
        (acc as Record<string, unknown>)[path] = (obj as Record<string, unknown>)[path];
      }
      return acc;
    },
    {} as Partial<T>,
  );
}

export function piniaPluginUniPersist(ctx: PiniaPluginContext) {
  const { store, options } = ctx;
  const persist = options.persist;

  if (!persist) return;

  const config: PersistOptions = typeof persist === "boolean" ? {} : persist;
  const storageKey = config.key ?? store.$id;

  const stored = uni.getStorageSync(storageKey);
  if (stored) {
    try {
      const parsed = typeof stored === "string" ? JSON.parse(stored) : stored;
      store.$patch(parsed);
    } catch {
      // 存储数据损坏时忽略
    }
  }

  store.$subscribe((_mutation, state) => {
    const data = config.paths ? pick(state, config.paths) : state;
    uni.setStorageSync(storageKey, JSON.stringify(data));
  });
}
