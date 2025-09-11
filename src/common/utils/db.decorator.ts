import { ObjectId } from 'mongodb'
import { FieldQueryTemp } from '@/common/utils/fieldQueryTemp';
import { ForeignDB } from './utils.types';
// DB参数装饰器处理 whereJson,dataJson,fieldJson,sortArr
export const TransformDbParams = (target, key, descriptor) => {
  const originalMethod = descriptor.value;
  // 修改原方法
  descriptor.value = async function (params) {
    if (params?.whereJson) {
      params.whereJson = transformWhereJson(params.whereJson);
    }
    if (params?.lastWhereJson) {
      params.lastWhereJson = transformWhereJson(params.lastWhereJson);
    }

    if (params?.dataJson) {
      params.dataJson = transformDataJson(params.dataJson);
    }

    if (params?.fieldJson) {
      params.fieldJson = transformFieldJson(params.fieldJson);
    }

    if (params?.sortArr) {
      params.sortArr = transformSortArr(params.sortArr);
    }

    if (params?.foreignDB) {
      params.foreignDB = transformForeignDB(params.foreignDB);
    }

    if (params?.addFields) {
      params.addFields = transFormAddFields(params.addFields);
    }

    if (params?.data) {
      params.data = transTableData(params.data);
    }
    // console.log('装饰器转换后的whereJson',JSON.stringify( params.whereJson, null, 2));
    // console.log('装饰器转换后的foreignDB',JSON.stringify( params.foreignDB, null, 2));
    // console.log('装饰器转换后的whereJson',JSON.stringify( params.whereJson, null, 2));


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
    // 对于 _id 为 objectId
    else if (key === '_id' && value instanceof ObjectId) {
      result[key] = value;
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
  const result: Record<string, any> = {};

  for (const key in dataJson) {
    if (!dataJson.hasOwnProperty(key)) continue;
    const value = dataJson[key];

    if (value instanceof FieldQueryTemp) {
      const built = value.buildDataJsonWithField(key);

      // 合并 built 到 result
      for (const op in built) {
        if (!result[op]) result[op] = {};
        // built[op] 可能是对象或字符串（$unset: field）
        if (typeof built[op] === 'object') {
          Object.assign(result[op], built[op]);
        } else {
          result[op][built[op]] = ""; // 如果 $unset 返回的是字段名字符串
        }
      }
      continue;
    }

    // 处理普通字段，默认 $set
    if (!result.$set) result.$set = {};
    result.$set[key] = value;
  }

  // 清理空对象
  for (const op of ['$set', '$unset', '$push']) {
    if (result[op] && Object.keys(result[op]).length === 0) {
      delete result[op];
    }
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

interface LookupStage {
  $lookup: {
    from: string;
    localField?: string;
    foreignField?: string;
    as: string;
    let?: Record<string, any>;
    pipeline?: Exclude<PipelineStage, { $lookup: any }>[];
  };
}

interface UnwindStage {
  $unwind: string | {
    path: string;
    preserveNullAndEmptyArrays?: boolean;
  };
}

type PipelineStage = LookupStage | UnwindStage | { [key: string]: any };

function transformForeignDB(foreignDB: ForeignDB[], currentDepth = 0): PipelineStage[] {
  const MAX_DEPTH = 15;
  if (currentDepth > MAX_DEPTH) {
    throw new Error(`关联查询嵌套层级超过最大限制 ${MAX_DEPTH}`);
  }

  return foreignDB.map(config => {
    const stages: PipelineStage[] = [];

    console.log('config', config)
    // 判断是否有_id字段
    const hasIdField = config.localKey === '_id' || config.foreignKey === '_id';
    // 判断LocalKey是否是对象
    const isLocalKeyObject = typeof config.localKey === 'object';
    const localKeyType = config.localKeyType
    const foreignKeyType = config.foreignKeyType

    // 创建基础表达式
    let matchExpression: any;

    if (localKeyType === 'array') {
      // localKey是数组，使用 $in 操作符
      matchExpression = {
        $in: [
          hasIdField ? { $toString: `$${config.foreignKey}` } : `$${config.foreignKey}`,
          "$$localVar",
        ]
      };
    } else if (foreignKeyType === 'array') {
      // foreignKey是数组，使用 $in 操作符（顺序调换）
      matchExpression = {
        $in: [
          hasIdField ? { $toString: `$${config.foreignKey}` } : `$${config.foreignKey}`,
          "$$localVar",
        ]
      };
    } else {
      // 默认情况，使用 $eq 操作符
      matchExpression = {
        $eq: [
          hasIdField ? { $toString: `$${config.foreignKey}` } : `$${config.foreignKey}`,
          "$$localVar"
        ]
      };
    }

    // 创建lookup阶段的pipeline
    const lookupPipeline: PipelineStage[] = [
      {
        $match: {
          $expr: {
            $and: [matchExpression]
          }
        }
      }
    ];

    // // 创建lookup阶段的pipeline
    // const lookupPipeline: PipelineStage[] = [
    //   {
    //     $match: {
    //       $expr: {
    //         $and: [
    //           {
    //             $eq: [
    //               hasIdField ? { $toString: `$${config.foreignKey}` } : `$${config.foreignKey}`, // _id字段转为字符串
    //               "$$localVar"
    //             ]
    //           }
    //         ]
    //       }
    //     }
    //   }
    // ];

    // 处理whereJson条件
    if (config.whereJson && Object.keys(config.whereJson).length > 0) {
      const processedWhere = {};

      for (const [field, value] of Object.entries(config.whereJson)) {
        if (value instanceof FieldQueryTemp) {
          Object.assign(processedWhere, value.buildForeignWhereJsonWithField(field));
        } else if (typeof value === 'object' && value !== null) {
          const nestedProcessed = {};
          for (const [nestedField, nestedValue] of Object.entries(value)) {
            if (nestedValue instanceof FieldQueryTemp) {
              Object.assign(nestedProcessed, nestedValue.buildForeignWhereJsonWithField(nestedField));
            } else {
              nestedProcessed[nestedField] = nestedValue;
            }
          }
          processedWhere[field] = nestedProcessed;
        } else {
          processedWhere[field] = value;
        }
      }

      if (Object.keys(processedWhere).length > 0) {
        lookupPipeline[0]['$match']['$expr']['$and'].push(processedWhere);
      }
    }

    // 添加fieldJson投影
    if (config.fieldJson && Object.keys(config.fieldJson).length > 0) {
      lookupPipeline.push({ $project: config.fieldJson });
    }

    // 添加自定义字段
    if (config.addFields) {
      const processedAddFields = {};
      for (const [field, value] of Object.entries(config.addFields)) {
        if (typeof value === 'object' && value !== null && !(value instanceof FieldQueryTemp)) {
          for (const [nestedField, nestedValue] of Object.entries(value)) {
            if (nestedValue instanceof FieldQueryTemp) {
              processedAddFields[field] = nestedValue.buildForeignAddFieldsWithField(nestedField);
            } else {
              processedAddFields[field] = value;
            }
          }
        } else if (value instanceof FieldQueryTemp) {
          processedAddFields[field] = value.buildForeignAddFieldsWithField(field);
        } else {
          processedAddFields[field] = value;
        }
      }
      lookupPipeline.push({ $addFields: processedAddFields });
    }

    // 添加sort排序
    if (config.sortArr?.length) {
      const sortObj = transformSortArr(config.sortArr);
      if (Object.keys(sortObj).length > 0) {
        lookupPipeline.push({ $sort: sortObj });
      }
    }

    // 递归处理嵌套foreignDB
    if (config.foreignDB?.length) {
      const nestedStages = transformForeignDB(config.foreignDB, currentDepth + 1);

      // 将嵌套的stages添加到当前pipeline中
      nestedStages.forEach(stage => {
        if ('$lookup' in stage) {
          const lookupStage = stage.$lookup;
          lookupPipeline.push({
            $lookup: {
              from: lookupStage.from,
              let: {
                // 使用当前文档的字段作为变量
                localVar: `${lookupStage.let.localVar}`
              },
              pipeline: lookupStage.pipeline,
              as: lookupStage.as
            }
          });

          // 如果嵌套的lookup有unwind，也添加到pipeline
          const nextStage = nestedStages[nestedStages.indexOf(stage) + 1];
          if (nextStage && '$unwind' in nextStage) {
            lookupPipeline.push({
              $unwind: {
                path: `$${nextStage.$unwind.path.substring(2)}`,
                preserveNullAndEmptyArrays: true
              }
            });
          }
        }
      });
    }

    // 创建主lookup阶段
    const lookupStage: PipelineStage = {
      $lookup: {
        from: config.dbName,
        let: {
          localVar: isLocalKeyObject
            ? config.localKey  // 如果是对象，直接使用
            : hasIdField
              ? { $toString: `$${config.localKey}` }
              : `$${config.localKey}`
        },
        pipeline: lookupPipeline,
        as: config.as
      }
    };
    stages.push(lookupStage);

    // 只有当limit=1时才添加unwind
    if (config.limit === 1) {
      stages.push({
        $unwind: {
          path: `$${config.as}`,
          preserveNullAndEmptyArrays: true
        }
      });
    }

    // 添加limit限制
    if (config.limit) {
      lookupPipeline.push({ $limit: config.limit });
    }

    return stages;
  }).flat();
}

function transFormAddFields(addFields: Record<string, any>): Record<string, any> {
  const result: Record<string, any> = {};

  for (const [key, value] of Object.entries(addFields)) {
    if (typeof value === 'string' && value.startsWith('$')) {
      // 处理直接字段引用（如 "$roles.sex"）
      result[key] = value;
    } else if (value instanceof FieldQueryTemp) {
      // 处理顶层的 FieldQueryTemp
      result[key] = value.buildAddFieldsWithField(key);
    } else if (isRolesSexCondition(value)) {
      // 处理 { 'roles.sex': _.gt(0) } 这种特殊格式
      const operator = Object.keys(value['roles.sex'].getOps())[0];
      const opValue = value['roles.sex'].getOps()[operator];

      result[key] = {
        $anyElementTrue: {
          $map: {
            input: "$roles",
            as: "r",
            in: { [operator]: ["$$r.sex", opValue] }
          }
        }
      };
    } else if (typeof value === 'object' && value !== null && !Array.isArray(value)) {
      // 递归处理其他嵌套对象
      result[key] = transFormAddFields(value);
    } else {
      // 保留原始值
      result[key] = value;
    }
  }

  return result;
}

// 判断是否是 { 'roles.sex': FieldQueryTemp } 这种结构
function isRolesSexCondition(obj: any): boolean {
  return (
    typeof obj === 'object' &&
    obj !== null &&
    !Array.isArray(obj) &&
    'roles.sex' in obj &&
    obj['roles.sex'] instanceof FieldQueryTemp
  );
}


function transTableData(data: any) {
  if (data.sortRule) {
    data.sortRule = transformSortArr(data.sortRule);
  }

  const match: any = {};
  for (const key in data.formData) {
      if (data.formData[key] === null) {
        delete data.formData[key]
      }
    }

  data.columns.forEach(col => {
    const value = data.formData[col.key];
    if (value === undefined || col.mode === "custom") return;

    switch (col.mode) {
      case "=": match[col.key] = value; break;
      case "!=": match[col.key] = { $ne: value }; break;
      case "%%": match[col.key] = { $regex: value, $options: "i" }; break;
      case "%*": match[col.key] = { $regex: `^${value}`, $options: "i" }; break;
      case "*%": match[col.key] = { $regex: `${value}$`, $options: "i" }; break;
      case ">": match[col.key] = { $gt: value }; break;
      case ">=": match[col.key] = { $gte: value }; break;
      case "<": match[col.key] = { $lt: value }; break;
      case "<=": match[col.key] = { $lte: value }; break;
      case "in": match[col.key] = { $in: value }; break;
      case "nin": match[col.key] = { $nin: value }; break;
      case "[]": match[col.key] = { $gte: value[0], $lte: value[1] }; break;
      case "[)": match[col.key] = { $gte: value[0], $lt: value[1] }; break;
      case "(]": match[col.key] = { $gt: value[0], $lte: value[1] }; break;
      case "()": match[col.key] = { $gt: value[0], $lt: value[1] }; break;
    }
  });
  data.match = match;
  return data;
}
