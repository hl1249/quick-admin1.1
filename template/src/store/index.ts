import { useUserStore } from './module/userStore'
export const useStore = () => {
  return {
    userStore: useUserStore(),
  }
}