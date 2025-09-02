// validation.pipe.ts
import { 
  PipeTransform, 
  Injectable, 
  ArgumentMetadata, 
  BadRequestException 
} from '@nestjs/common';
import { validate } from 'class-validator';
import { plainToInstance } from 'class-transformer';

@Injectable()
export class ValidationPipe implements PipeTransform<any> {
  async transform(value: any, { metatype }: ArgumentMetadata) {
    if (!metatype || !this.shouldValidate(metatype)) {
      return value;
    }

    const object = plainToInstance(metatype, value, {
      enableImplicitConversion: true,
      excludeExtraneousValues: false,
    });

    const errors = await validate(object, {
      whitelist: true,
      forbidNonWhitelisted: true,
      forbidUnknownValues: true,
      stopAtFirstError: false,
    });

    if (errors.length > 0) {
      const errorMessages = this.flattenValidationErrors(errors);
      throw new BadRequestException({
        message: 'Validation failed',
        errors: errorMessages,
        statusCode: 400,
      });
    }

    return object; // 返回转换后的实例而不是原始值
  }

  private shouldValidate(metatype: any): boolean {
    const types: Function[] = [String, Boolean, Number, Array, Object];
    return !types.includes(metatype);
  }

  private flattenValidationErrors(errors: any[]): string[] {
    return errors.flatMap(error => {
      if (error.constraints) {
        return Object.values(error.constraints);
      }
      
      if (error.children && error.children.length > 0) {
        return this.flattenValidationErrors(error.children).map(
          childError => `${error.property}.${childError}`
        );
      }
      
      return [`${error.property}: Validation failed`];
    });
  }
}