import { defineConfig, loadEnv } from "vite";
import uni from "@dcloudio/vite-plugin-uni";
import tailwindcss from "@tailwindcss/postcss";
import UniManifest from "@uni-helper/vite-plugin-uni-manifest";
import { UnifiedViteWeappTailwindcssPlugin } from "weapp-tailwindcss/vite";
import { fileURLToPath, URL } from "node:url";
import { resolve } from "node:path";

// https://vitejs.dev/config/
export default defineConfig(async ({ mode }) => {
  const env = loadEnv(mode, "env");
  const enableProxy = env.VITE_APP_PROXY_ENABLE === "true";
  const port = Number(env.VITE_APP_PORT || 5173);

  return {
    envDir: "env",
    resolve: {
      alias: {
        "@store": resolve(__dirname, "src/store"),
      },
    },
    server: {
      port,
      proxy: enableProxy
        ? {
            "/api": {
              target: "http://localhost:3000",
              changeOrigin: true,
            },
          }
        : undefined,
    },
    plugins: [
      await UniManifest(),
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
  };
});
