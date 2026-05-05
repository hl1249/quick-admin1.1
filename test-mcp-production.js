#!/usr/bin/env node
/**
 * MCP 生产环境测试脚本
 * 用于验证 MCP 模块在生产环境下的可用性
 */

const http = require('http');

const BASE_URL = 'http://localhost:3000';

// 发送 HTTP 请求
function request(method, path, body = null) {
  return new Promise((resolve, reject) => {
    const options = {
      hostname: 'localhost',
      port: 3000,
      path: path,
      method: method,
      headers: {
        'Content-Type': 'application/json',
      },
    };

    const req = http.request(options, (res) => {
      let data = '';
      res.on('data', (chunk) => (data += chunk));
      res.on('end', () => {
        try {
          resolve(JSON.parse(data));
        } catch (e) {
          resolve(data);
        }
      });
    });

    req.on('error', reject);
    req.setTimeout(30000, () => {
      req.destroy();
      reject(new Error('Request timeout'));
    });

    if (body) {
      req.write(JSON.stringify(body));
    }
    req.end();
  });
}

async function testMCP() {
  console.log('='.repeat(60));
  console.log('MCP 生产环境测试');
  console.log('='.repeat(60));

  // 测试 1: 基础聊天
  console.log('\n[测试 1] POST /mcp/chat - 基础聊天');
  try {
    const result = await request('POST', '/mcp/chat', {
      message: '你好，请简单介绍一下自己',
    });
    console.log('✅ 成功:', result.success);
    if (result.success) {
      console.log('回复:', result.data.reply.substring(0, 100) + '...');
    }
  } catch (error) {
    console.log('❌ 失败:', error.message);
  }

  // 测试 2: 智能聊天
  console.log('\n[测试 2] POST /mcp/chat/smart - 智能聊天');
  try {
    const result = await request('POST', '/mcp/chat/smart', {
      message: '桌面上有哪些文件？',
    });
    console.log('✅ 成功:', result.success);
    if (result.success) {
      console.log('回复:', result.data.reply.substring(0, 100) + '...');
    }
  } catch (error) {
    console.log('❌ 失败:', error.message);
  }

  // 测试 3: 查找文件
  console.log('\n[测试 3] GET /mcp/files - 查找文件');
  try {
    const result = await request(
      'GET',
      '/mcp/files?folder=desktop&extensions=.png,.jpg&maxResults=5'
    );
    console.log('✅ 成功:', result.success);
    if (result.success) {
      console.log('找到文件数:', result.data.count);
      if (result.data.files.length > 0) {
        console.log('示例文件:', result.data.files[0].name);
      }
    }
  } catch (error) {
    console.log('❌ 失败:', error.message);
  }

  console.log('\n' + '='.repeat(60));
  console.log('测试完成');
  console.log('='.repeat(60));
}

// 运行测试
testMCP().catch(console.error);
