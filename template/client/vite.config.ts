import { defineConfig } from "vite";
import uni from "@dcloudio/vite-plugin-uni";
import tailwindcss from "@tailwindcss/postcss";
import { UnifiedViteWeappTailwindcssPlugin } from "weapp-tailwindcss/vite";
import { fileURLToPath, URL } from "node:url";

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [
    uni(),
    UnifiedViteWeappTailwindcssPlugin({
      rem2rpx: true,
      cssEntries: [fileURLToPath(new URL("./src/app.css", import.meta.url))],
    }),
  ],
  css: {
    postcss: {
      plugins: [tailwindcss()],
    },
  },
});
