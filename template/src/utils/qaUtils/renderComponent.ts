// utils/renderComponent.ts
import { createApp,} from 'vue'
import type { App, Component, ComponentPublicInstance } from 'vue'

export interface RenderResult<T> {
  /** Vue 实例（组件实例） */
  instance: ComponentPublicInstance<T>
  /** Vue App 实例 */
  app: App
  /** 卸载函数 */
  unmount: () => void
}

/**
 * 动态渲染 Vue 组件
 * @param Component 要渲染的组件
 * @param props 传递给组件的 props
 * @param container 可选，挂载的 DOM 容器
 * @returns 包含 instance 和 unmount 方法
 */
export function renderComponent<T extends Record<string, any>>(
  Component: Component,
  props?: T,
  container?: HTMLElement
): RenderResult<T> {
  const app = createApp(Component, props)
  const mountNode = container || document.createElement('div')
  document.body.appendChild(mountNode)

  const instance = app.mount(mountNode) as ComponentPublicInstance<T>

  return {
    app,
    instance,
    unmount() {
      app.unmount()
      mountNode.remove()
    }
  }
}
