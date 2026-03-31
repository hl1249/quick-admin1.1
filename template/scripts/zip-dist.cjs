const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

const distDir = path.join(__dirname, '..', 'dist');
const outputZip = path.join(__dirname, '..', 'dist.zip');

if (!fs.existsSync(distDir)) {
  console.error('dist 目录不存在，请先执行 build');
  process.exit(1);
}

if (fs.existsSync(outputZip)) {
  fs.unlinkSync(outputZip);
  console.log('已删除旧的 dist.zip');
}

// 使用 PowerShell 的 Compress-Archive 进行打包
try {
  execSync(
    `powershell -Command "Compress-Archive -Path '${distDir}\\*' -DestinationPath '${outputZip}' -Force"`,
    { stdio: 'inherit' }
  );
  const stat = fs.statSync(outputZip);
  const sizeMB = (stat.size / 1024 / 1024).toFixed(2);
  console.log(`打包完成: dist.zip (${sizeMB} MB)`);
} catch (e) {
  console.error('打包失败:', e.message);
  process.exit(1);
}
