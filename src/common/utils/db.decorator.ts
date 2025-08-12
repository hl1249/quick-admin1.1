import { ObjectId } from 'mongodb'
import { FieldQueryTemp } from '@/common/utils/fieldQueryTemp';
// whereJson装饰器
export const WhereJsonDecorator = (target, key, descriptor) => {
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
        console.log('装饰器转换后的dataJson', params.dataJson);
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
        
        // Handle FieldQueryTemp instances
        if (value instanceof FieldQueryTemp) {
            Object.assign(result, value.buildWithField(key));
        } 
        // Handle field placeholders
        else if (typeof value === 'object' && value.__field_placeholder__) {
            result[key] = value.__field_placeholder__;
        }
        // Handle _id conversion
        else if (key === '_id' && typeof value === 'string' && ObjectId.isValid(value)) {
            result[key] = new ObjectId(value);
        }
        // Handle nested _id objects (like $eq, $in operators)
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
        // Recursively transform other values
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