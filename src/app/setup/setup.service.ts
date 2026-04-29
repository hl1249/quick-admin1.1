import { Injectable } from '@nestjs/common';
import { InjectConnection } from '@nestjs/mongoose';
import { ObjectId } from 'mongodb';
import { existsSync } from 'node:fs';
import { readdir, readFile } from 'node:fs/promises';
import { join } from 'node:path';
import { Connection } from 'mongoose';

export interface InstallCollectionResult {
  collection: string;
  count: number;
}

export interface InstallDatabaseResult {
  installed: boolean;
  skipped: boolean;
  database: string;
  message: string;
  collections: InstallCollectionResult[];
}

const objectIdPattern = /^[0-9a-f]{24}$/i;

@Injectable()
export class SetupService {
  constructor(@InjectConnection() private readonly connection: Connection) {}

  async getStatus() {
    const dbPath = this.getDbPath();
    const files = await this.getSeedFiles(dbPath);
    const databaseExists = await this.databaseExists();
    const collections = await Promise.all(
      files.map(async (file) => {
        const collection = this.getCollectionName(file);
        const count = await this.connection.collection(collection).countDocuments();
        return { collection, count };
      }),
    );

    return {
      database: this.connection.name,
      databaseExists,
      seedFiles: files.length,
      collections,
    };
  }

  async installDatabase(): Promise<InstallDatabaseResult> {
    const databaseExists = await this.databaseExists();
    if (databaseExists) {
      return {
        installed: false,
        skipped: true,
        database: this.connection.name,
        message: `${this.connection.name} 数据库已存在，已跳过安装。`,
        collections: [],
      };
    }

    const dbPath = this.getDbPath();
    const files = await this.getSeedFiles(dbPath);
    const collections: InstallCollectionResult[] = [];

    for (const file of files) {
      const collectionName = this.getCollectionName(file);
      const rows = await this.readSeedFile(join(dbPath, file));
      const collection = this.connection.collection(collectionName);

      await collection.deleteMany({});
      if (rows.length > 0) {
        await collection.insertMany(rows);
      }

      collections.push({
        collection: collectionName,
        count: rows.length,
      });
    }

    return {
      installed: true,
      skipped: false,
      database: this.connection.name,
      message: `${this.connection.name} 数据库安装完成。`,
      collections,
    };
  }

  private async databaseExists(): Promise<boolean> {
    const database = this.connection.name;
    const admin = this.connection.getClient().db().admin();
    const result = await admin.listDatabases({ nameOnly: true });
    return result.databases.some((item) => item.name === database);
  }

  private getDbPath(): string {
    return join(process.cwd(), 'db');
  }

  private async getSeedFiles(dbPath: string): Promise<string[]> {
    if (!existsSync(dbPath)) {
      throw new Error(`数据库初始化目录不存在: ${dbPath}`);
    }

    const files = await readdir(dbPath);
    return files
      .filter((file) => file.startsWith('qa-') && file.endsWith('.json'))
      .sort();
  }

  private getCollectionName(file: string): string {
    return file.replace(/\.json$/i, '');
  }

  private async readSeedFile(filePath: string): Promise<Record<string, unknown>[]> {
    const raw = await readFile(filePath, 'utf8');
    const data = JSON.parse(raw) as Record<string, unknown>[];

    if (!Array.isArray(data)) {
      throw new Error(`初始化文件必须是数组: ${filePath}`);
    }

    return data.map((item) => this.normalizeDocument(item));
  }

  private normalizeDocument(item: Record<string, unknown>): Record<string, unknown> {
    const doc = { ...item };
    if (typeof doc._id === 'string' && objectIdPattern.test(doc._id)) {
      doc._id = new ObjectId(doc._id);
    }
    return doc;
  }
}
