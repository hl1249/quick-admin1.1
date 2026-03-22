import { cpSync, existsSync, mkdirSync, rmSync } from 'node:fs';
import { join } from 'node:path';

const rootDir = process.cwd();
const buildDistDir = join(rootDir, 'dist');
const deployDir = join(rootDir, 'deploy');
const deployDistDir = join(deployDir, 'dist');

rmSync(deployDir, { recursive: true, force: true });
mkdirSync(deployDir, { recursive: true });

if (!existsSync(buildDistDir)) {
  throw new Error('[build] missing dist directory, run nest build first');
}

cpSync(buildDistDir, deployDistDir, { recursive: true });
console.log('[build] copied: dist -> deploy/dist');

const filesToCopy = ['.env', 'package.json', 'pnpm-lock.yaml'];

for (const file of filesToCopy) {
  const source = join(rootDir, file);
  const target = join(deployDir, file);

  if (!existsSync(source)) {
    console.warn(`[build] skip missing file: ${file}`);
    continue;
  }

  cpSync(source, target);
  console.log(`[build] copied: ${file}`);
}

const startScriptSource = join(rootDir, 'scripts', 'start.js');
const startScriptTarget = join(deployDir, 'start.js');

if (existsSync(startScriptSource)) {
  cpSync(startScriptSource, startScriptTarget);
  console.log('[build] copied: start.js');
} else {
  console.warn('[build] skip missing file: scripts/start.js');
}

rmSync(buildDistDir, { recursive: true, force: true });
console.log('[build] removed: dist');
