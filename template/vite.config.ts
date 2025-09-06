import { defineConfig, loadEnv } from 'vite'
import vue from '@vitejs/plugin-vue'
import { resolve } from 'path'
import AutoImport from 'unplugin-auto-import/vite'
import Components from 'unplugin-vue-components/vite'
import { ElementPlusResolver } from 'unplugin-vue-components/resolvers'
import vueJsx from "@vitejs/plugin-vue-jsx";

export default defineConfig(async ({ mode }) => {
  const { VITE_PORT, VITE_OPEN, VITE_BASE_PATH, VITE_OUT_DIR } = loadEnv(mode, process.cwd())

  return {
    plugins: [vue(),
      vueJsx(),
    AutoImport({
      imports: ['vue'], // 自动引入 vue 的 API
      dts: 'src/auto-imports.d.ts', // 自动生成类型声明文件
      resolvers: [ElementPlusResolver()],
    }),
    Components({
      resolvers: [ElementPlusResolver()],
    }),
    ],
    resolve: {
      alias: {
        '@': resolve(__dirname, 'src'),
      },
    },
    server: {
      port: parseInt(VITE_PORT),
      open: Boolean(VITE_OPEN),
      proxy: {
        '/api': {
          target: 'http://localhost:3001',
          secure: false,
          changeOrigin: true,
          rewrite: (path:string) => path.replace(/^\/api/, ''),
        },
      },
    },
    base: VITE_BASE_PATH,
    build: {
      cssCodeSplit: false,
      sourcemap: false,
      outDir: VITE_OUT_DIR,
      emptyOutDir: true,
      chunkSizeWarningLimit: 1500,
      rollupOptions: {
        output: {
          manualChunks: {
            // 分包配置，配置完成自动按需加载
            vue: ['vue', 'vue-router', 'pinia', 'element-plus'],
            echarts: ['echarts'],
          },
        },
      },
    },
  }
})