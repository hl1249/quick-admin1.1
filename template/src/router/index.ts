import { createRouter , createMemoryHistory, createWebHistory } from 'vue-router'
import staticRouter from './staticRouter'

const router = createRouter({
  history: createWebHistory(),
  routes: [
    ...staticRouter
  ],
})

export default router