import pluginVue from 'eslint-plugin-vue';
import vueTsEslintConfig from '@vue/eslint-config-typescript';

export default [
  {
    files: ['**/*.{js,mjs,cjs,ts,vue}'],
  },
  ...pluginVue.configs['flat/recommended'],
  ...vueTsEslintConfig(),
  {
    rules: {
      '@typescript-eslint/no-unsafe-assignment': 'off',
    },
    ignores: ['vite.config.ts'],
  },
];
