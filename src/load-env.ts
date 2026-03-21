import { config } from 'dotenv';
import { join } from 'node:path';

/** 项目根目录下的 .env（与 cwd 无关，避免从任意目录启动时仍误用默认 CACHE_TYPE=redis 等） */
const envPath = join(__dirname, '..', '.env');
config({ path: envPath });
