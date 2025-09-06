import { useAuthStore } from './modules/authStore'
import { useMenuStore } from './modules/menuStore'
export const useStore = () => {
  return {
    authStore: useAuthStore(),
    menuStore: useMenuStore()
  }
}