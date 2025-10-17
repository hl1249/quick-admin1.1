import { useAuthStore } from './modules/authStore'
import { useMenuStore } from './modules/menuStore'

export function useStore() {
  return {
    authStore: useAuthStore(),
    menuStore: useMenuStore(),
  }
}