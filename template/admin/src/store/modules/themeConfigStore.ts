import { defineStore } from 'pinia'

export const useThemeConfigStore = defineStore(
  'themeConfig',
  () => {
    const isSearch = ref(false)

    return { isSearch }
  },
  {
    persist: true,
  },
)
