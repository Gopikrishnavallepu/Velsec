import { defineConfig } from 'vitest/config';
import react from '@vitejs/plugin-react';
import { resolve } from 'path';

export default defineConfig({
  plugins: [react()],
  test: {
    environment: 'jsdom',
    globals: true,
    setupFiles: ['./vitest.setup.ts'],
    include: ['src/__tests__/**/*.ts', 'src/__tests__/**/*.tsx'],
    alias: {
      '@': resolve(__dirname, './src')
    }
  }
});
