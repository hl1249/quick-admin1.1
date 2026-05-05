import { Injectable } from '@nestjs/common';
import { mkdir, readFile, readdir, stat, writeFile } from 'node:fs/promises';
import { basename, dirname, extname, join, relative, resolve } from 'node:path';

export interface FileInfo {
  name: string;
  path: string;
  relativePath: string;
  sizeBytes: number;
  modifiedAt: string;
}

export interface FindFilesResult {
  folder: string;
  extensions: string[] | null;
  recursive: boolean;
  count: number;
  truncated: boolean;
  files: FileInfo[];
}

export interface ReadFileResult {
  path: string;
  sizeBytes: number;
  modifiedAt: string;
  truncated: boolean;
  content: string;
}

export interface WriteFileResult {
  path: string;
  sizeBytes: number;
  modifiedAt: string;
  createdOrOverwritten: boolean;
}

export interface EditFileResult {
  path: string;
  sizeBytes: number;
  modifiedAt: string;
  edited: boolean;
}

@Injectable()
export class FileService {
  /**
   * 解析本地路径
   */
  private resolveLocalPath(folder: string = 'desktop', basePath: string): string {
    const normalizedFolder = String(folder || 'desktop').trim();
    const target =
      normalizedFolder.toLowerCase() === 'desktop' || normalizedFolder === '桌面'
        ? basePath
        : resolve(basePath, normalizedFolder);

    return resolve(target);
  }

  /**
   * 检查是否为敏感文件
   */
  private isSensitiveFile(filePath: string): boolean {
    const name = basename(filePath).toLowerCase();

    return (
      name === '.env' ||
      name.endsWith('.pem') ||
      name.endsWith('.key') ||
      name.endsWith('.pfx') ||
      name.endsWith('.p12') ||
      name.includes('secret') ||
      name.includes('credential')
    );
  }

  /**
   * 查找文件
   */
  async findFiles(
    options: {
      folder?: string;
      extensions?: string[];
      recursive?: boolean;
      maxResults?: number;
    },
    basePath: string,
    onProgress?: (msg: string) => void,
  ): Promise<FindFilesResult> {
    const {
      folder = 'desktop',
      extensions,
      recursive = false,
      maxResults = 200,
    } = options;

    const root = this.resolveLocalPath(folder, basePath);
    onProgress?.(`正在扫描 ${root}`);

    const extensionSet = extensions?.length
      ? new Set(
          extensions.map((item) =>
            item.startsWith('.') ? item.toLowerCase() : `.${item.toLowerCase()}`,
          ),
        )
      : null;
    const results: FileInfo[] = [];
    const limit = Math.max(1, Math.min(Number(maxResults) || 200, 1000));

    const walk = async (currentDir: string) => {
      if (results.length >= limit) {
        return;
      }

      const entries = await readdir(currentDir, { withFileTypes: true });

      for (const entry of entries) {
        if (results.length >= limit) {
          return;
        }

        if (entry.name === 'node_modules' || entry.name === '.git') {
          continue;
        }

        const fullPath = join(currentDir, entry.name);

        if (entry.isDirectory()) {
          if (recursive) {
            await walk(fullPath);
          }
          continue;
        }

        if (
          !entry.isFile() ||
          (extensionSet && !extensionSet.has(extname(entry.name).toLowerCase()))
        ) {
          continue;
        }

        const fileStat = await stat(fullPath);

        results.push({
          name: entry.name,
          path: fullPath,
          relativePath: relative(root, fullPath),
          sizeBytes: fileStat.size,
          modifiedAt: fileStat.mtime.toISOString(),
        });
      }
    };

    await walk(root);
    onProgress?.(`扫描完成，找到 ${results.length} 个文件`);

    return {
      folder: root,
      extensions: extensionSet ? Array.from(extensionSet) : null,
      recursive,
      count: results.length,
      truncated: results.length >= limit,
      files: results,
    };
  }

  /**
   * 读取文件
   */
  async readFile(
    options: { path: string; maxBytes?: number },
    basePath: string,
    onProgress?: (msg: string) => void,
  ): Promise<ReadFileResult> {
    const { path: filePath, maxBytes = 20000 } = options;

    if (!filePath) {
      throw new Error('Missing required parameter: path');
    }

    const resolvedPath = this.resolveLocalPath(filePath, basePath);

    if (this.isSensitiveFile(resolvedPath)) {
      throw new Error('Refusing to read sensitive file content.');
    }

    onProgress?.(`正在读取 ${resolvedPath}`);

    const fileStat = await stat(resolvedPath);

    if (!fileStat.isFile()) {
      throw new Error(`Path is not a file: ${resolvedPath}`);
    }

    const limit = Math.max(1, Math.min(Number(maxBytes) || 20000, 100000));
    const content = await readFile(resolvedPath, 'utf8');
    const truncated = Buffer.byteLength(content, 'utf8') > limit;
    const slicedContent = Buffer.from(content, 'utf8')
      .subarray(0, limit)
      .toString('utf8');
    onProgress?.(`读取完成${truncated ? '，内容已截断' : ''}`);

    return {
      path: resolvedPath,
      sizeBytes: fileStat.size,
      modifiedAt: fileStat.mtime.toISOString(),
      truncated,
      content: slicedContent,
    };
  }

  /**
   * 写入文件
   */
  async writeFile(
    options: { path: string; content: string },
    basePath: string,
    onProgress?: (msg: string) => void,
  ): Promise<WriteFileResult> {
    const { path: filePath, content } = options;

    if (!filePath) {
      throw new Error('Missing required parameter: path');
    }

    if (content === undefined) {
      throw new Error('Missing required parameter: content');
    }

    const resolvedPath = this.resolveLocalPath(filePath, basePath);

    if (this.isSensitiveFile(resolvedPath)) {
      throw new Error('Refusing to write sensitive file content.');
    }

    onProgress?.(`正在写入 ${resolvedPath}`);

    await mkdir(dirname(resolvedPath), { recursive: true });
    await writeFile(resolvedPath, String(content), 'utf8');

    const fileStat = await stat(resolvedPath);
    onProgress?.('写入完成');

    return {
      path: resolvedPath,
      sizeBytes: fileStat.size,
      modifiedAt: fileStat.mtime.toISOString(),
      createdOrOverwritten: true,
    };
  }

  /**
   * 编辑文件
   */
  async editFile(
    options: { path: string; oldText: string; newText: string },
    basePath: string,
    onProgress?: (msg: string) => void,
  ): Promise<EditFileResult> {
    const { path: filePath, oldText, newText } = options;

    if (!filePath) {
      throw new Error('Missing required parameter: path');
    }

    if (oldText === undefined || newText === undefined) {
      throw new Error('Missing required parameters: oldText and newText');
    }

    const resolvedPath = this.resolveLocalPath(filePath, basePath);

    if (this.isSensitiveFile(resolvedPath)) {
      throw new Error('Refusing to edit sensitive file content.');
    }

    onProgress?.(`正在修改 ${resolvedPath}`);

    const fileStat = await stat(resolvedPath);

    if (!fileStat.isFile()) {
      throw new Error(`Path is not a file: ${resolvedPath}`);
    }

    const content = await readFile(resolvedPath, 'utf8');
    const firstIndex = content.indexOf(oldText);

    if (firstIndex === -1) {
      throw new Error('oldText was not found in the file.');
    }

    if (content.indexOf(oldText, firstIndex + oldText.length) !== -1) {
      throw new Error('oldText appears more than once; provide a larger unique block.');
    }

    const updatedContent = content.replace(oldText, newText);

    await writeFile(resolvedPath, updatedContent, 'utf8');

    const updatedStat = await stat(resolvedPath);
    onProgress?.('修改完成');

    return {
      path: resolvedPath,
      sizeBytes: updatedStat.size,
      modifiedAt: updatedStat.mtime.toISOString(),
      edited: true,
    };
  }
}
