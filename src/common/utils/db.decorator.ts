import { ObjectId } from 'mongodb'
import { FieldQueryTemp } from '@/common/utils/fieldQueryTemp';
// DB参数装饰器处理 whereJson,dataJson,fieldJson,sortArr
export const TransformDbParams = (target, key, descriptor) => {
    const originalMethod = descriptor.value;
    // 修改原方法
    descriptor.value = async function (params) {
        console.log('装饰器params', params);
        if (params?.whereJson) {
            params.whereJson = transformWhereJson(params.whereJson);
        }

        if(params?.dataJson) {
            params.dataJson = transformDataJson(params.dataJson);
        }

        if(params?.fieldJson) {
            params.fieldJson = transformFieldJson(params.fieldJson);
        }

        if(params?.sortArr) {
            params.sortArr = transformSortArr(params.sortArr);
        }

        if(params?.foreignDB) {
            params.foreignDB = transformForeignDB(params.foreignDB);
        }
        console.log('装饰器转换后的foreignDB', params.foreignDB);
        return await originalMethod.call(this, params);
    }

    return descriptor;
}

// 转换whereJson 中的操作符
// 例 { gt: 20 } 转换为 { __op: '$gt', value: 20 }
function transformWhereJson(whereJson: Record<string, any>): Record<string, any> {
    if (typeof whereJson !== 'object' || whereJson === null) return whereJson;

    // Handle $and and $or operators recursively
    if (whereJson.$and) {
        return { $and: whereJson.$and.map(transformWhereJson) };
    }
    if (whereJson.$or) {
        return { $or: whereJson.$or.map(transformWhereJson) };
    }

    const result: Record<string, any> = {};
    for (const key in whereJson) {
        const value = whereJson[key];
        
        // 对于 FieldQueryTemp 实例，直接调用 buildWithField 方法
        if (value instanceof FieldQueryTemp) {
            Object.assign(result, value.buildWithField(key));
        } 
        // 对于普通对象，递归转换
        else if (typeof value === 'object' && value.__field_placeholder__) {
            result[key] = value.__field_placeholder__;
        }
        // 对于正则表达式，转换为 MongoDB 的 $regex 格式
        else if (value instanceof RegExp) {
            result[key] = { $regex: value };
        }
        // 对于 _id，转换为 ObjectId 对象
        else if (key === '_id' && typeof value === 'string' && ObjectId.isValid(value)) {
            result[key] = new ObjectId(value);
        }
        // 对于 _id 的特殊处理
        else if (key === '_id' && typeof value === 'object' && value !== null) {
            const transformedIdObj: Record<string, any> = {};
            for (const op in value) {
                if (typeof value[op] === 'string' && ObjectId.isValid(value[op])) {
                    transformedIdObj[op] = new ObjectId(value[op]);
                } else if (Array.isArray(value[op])) {
                    transformedIdObj[op] = value[op].map((item: any) => 
                        typeof item === 'string' && ObjectId.isValid(item) ? new ObjectId(item) : item
                    );
                } else {
                    transformedIdObj[op] = value[op];
                }
            }
            result[key] = transformedIdObj;
        }
        // 对于其他类型的值，直接赋值
        else {
            result[key] = transformWhereJson(value);
        }
    }
    return result;
}

function transformDataJson(dataJson: Record<string, any>): Record<string, any> {
  const result: Record<string, any> = { $set: {}, $unset: {} };

  for (const key in dataJson) {
    if (dataJson.hasOwnProperty(key)) {
      const value = dataJson[key];
      
      // Check if the value is an object with $unset property
      if (typeof value === 'object' && value !== null && '$unset' in value) {
        result.$unset[key] = value.$unset;
      } 
      // Check if the value is a function (like _.remove())
      else if (typeof value === 'function') {
        result.$unset[key] = "";
      } 
      else {
        result.$set[key] = value;
      }
    }
  }

  // Clean up empty objects
  if (Object.keys(result.$set).length === 0) {
    delete result.$set;
  }
  if (Object.keys(result.$unset).length === 0) {
    delete result.$unset;
  }

  return result;
}

function transformFieldJson(value: any): any {
  if (value instanceof FieldQueryTemp) {
    return value.getOps();
  }
  
  // Handle the field projection transformation
  if (typeof value === 'object' && value !== null) {
    const result: Record<string, any> = {};
    for (const key in value) {
      if (value[key] === true) {
        result[key] = 1;
      } else if (value[key] === false) {
        result[key] = 0;
      } else {
        result[key] = value[key]; // leave other values unchanged
      }
    }
    return result;
  }
  
  return value;
}

function transformSortArr(sortArr: any[]): any {
  if (!Array.isArray(sortArr)) return sortArr;

  const result: Record<string, number> = {};
  
  for (const item of sortArr) {
    if (item && typeof item === 'object' && item.name && item.type) {
      result[item.name] = item.type.toLowerCase() === 'desc' ? -1 : 1;
    }
  }
  
  return result;
}

interface ForeignDBConfig {
  dbName: string;
  localKey: string;
  foreignKey: string;
  as: string;
  limit?: number;
  foreignDB?: ForeignDBConfig[];
}

type PipelineStage = 
  | { $lookup: { from: string; localField: string; foreignField: string; as: string } }
  | { $unwind: string };

function transformForeignDB(foreignDB: ForeignDBConfig[], currentDepth = 0): PipelineStage[] {
  // 防止递归过深（云数据库通常限制最多15层）
  const MAX_DEPTH = 15;
  if (currentDepth > MAX_DEPTH) {
    throw new Error(`关联查询嵌套层级超过最大限制 ${MAX_DEPTH}`);
  }

  return foreignDB.map(config => {
    const stages: PipelineStage[] = [];
    
    // 处理当前层级的lookup
    const lookupStage: PipelineStage = {
      $lookup: {
        from: config.dbName,
        localField: config.localKey,
        foreignField: config.foreignKey,
        as: config.as
      }
    };
    stages.push(lookupStage);

    // 如果指定了limit为1，则添加$unwind
    if (config.limit === 1) {
      stages.push({ $unwind: `$${config.as}` });
    }

    // 如果有嵌套的foreignDB，递归处理
    if (config.foreignDB && config.foreignDB.length > 0) {
      // 嵌套的lookup需要在当前lookup之后执行
      const nestedStages = transformForeignDB(config.foreignDB, currentDepth + 1);
      
      // 我们需要修改嵌套的lookup，使其在子文档上操作
      const modifiedNestedStages = nestedStages.map(stage => {
        if ('$lookup' in stage) {
          // 修改localField路径，加上父级的as前缀
          return {
            $lookup: {
              ...stage.$lookup,
              localField: `${config.as}.${stage.$lookup.localField}`,
              as: `${config.as}.${stage.$lookup.as}`
            }
          };
        } else if ('$unwind' in stage) {
          // 修改unwind路径，加上父级的as前缀
          return {
            $unwind: `$${config.as}.${stage.$unwind.substring(1)}`
          };
        }
        return stage;
      });

      stages.push(...modifiedNestedStages);
    }

    return stages;
  }).flat();
}