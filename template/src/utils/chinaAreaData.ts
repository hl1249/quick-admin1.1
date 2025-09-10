
export interface RegionItem {
  value: string;
  label: string;
  children?: RegionItem[];
}

// 定义 JSON 的类型
interface RegionJSON {
  [code: string]: string | Record<string, string | Record<string, string>>;
}

export interface TextToCodeItem {
  code: string;
  [key: string]: TextToCodeItem | string;
}

export interface TextToCodeMap {
  [provinceOrCity: string]: TextToCodeItem;
}

export interface CodeToTextMap {
  [code: string]: string;
}

export function cloneDeep<T>(value: T): T {
  if (value === null || typeof value !== 'object') {
    return value;
  }

  if (value instanceof Date) {
    return new Date(value.getTime()) as any;
  }

  if (Array.isArray(value)) {
    return value.map(item => cloneDeep(item)) as any;
  }

  const objCopy: any = {};
  for (const key in value) {
    if (Object.prototype.hasOwnProperty.call(value, key)) {
      objCopy[key] = cloneDeep((value as any)[key]);
    }
  }
  return objCopy;
}

import REGION_DATA_RAW from './areaData/data.json' assert { type: 'json' };
const REGION_DATA = REGION_DATA_RAW as RegionJSON;

// code转汉字大对象
const CodeToText: CodeToTextMap = {};
// 汉字转code大对象
const TextToCode: TextToCodeMap = {};

const provinceObject = REGION_DATA['86'] as Record<string, string>;
const regionData: RegionItem[] = [];
let provinceAndCityData: RegionItem[] = [];

CodeToText[''] = '全部';

// 计算省份
for (const prop in provinceObject) {
  regionData.push({
    value: prop,
    label: provinceObject[prop]
  });
  CodeToText[prop] = provinceObject[prop];
  TextToCode[provinceObject[prop]] = {
    code: prop,
    '全部': { code: '' }
  };
}

// 计算市
for (const province of regionData) {
  const provinceCode = province.value;
  const provinceText = province.label;
  const provinceChildren: RegionItem[] = [];

  const cityData = REGION_DATA[provinceCode] as Record<string, string>;
  for (const prop in cityData) {
    provinceChildren.push({
      value: prop,
      label: cityData[prop]
    });
    CodeToText[prop] = cityData[prop];

    if (!TextToCode[provinceText]) TextToCode[provinceText] = { code: provinceCode } as any;
    TextToCode[provinceText][cityData[prop]] = { code: prop, '全部': { code: '' } };
  }

  if (provinceChildren.length) province.children = provinceChildren;
}

provinceAndCityData = cloneDeep(regionData);

// 计算区
for (const province of regionData) {
  const provinceChildren = province.children;
  const provinceText = province.label;

  if (!provinceChildren) continue;

  for (const city of provinceChildren) {
    const cityCode = city.value;
    const cityText = city.label;
    const cityChildren: RegionItem[] = [];

    const districtData = REGION_DATA[cityCode] as Record<string, string>;
    for (const prop in districtData) {
      cityChildren.push({
        value: prop,
        label: districtData[prop]
      });
      CodeToText[prop] = districtData[prop];

      if (!TextToCode[provinceText][cityText]) TextToCode[provinceText][cityText] = {} as TextToCodeItem;
      (TextToCode[provinceText][cityText] as TextToCodeItem)[districtData[prop]] = { code: prop };

    }

    if (cityChildren.length) city.children = cityChildren;
  }
}

// 添加“全部”选项
function addAllOption(data: RegionItem[]): RegionItem[] {
  const copy = cloneDeep(data);
  copy.unshift({ value: '', label: '全部' });

  for (const province of copy) {
    if (province.children && province.children.length) {
      province.children.unshift({ value: '', label: '全部' });
      for (const city of province.children) {
        if (city.children && city.children.length) {
          city.children.unshift({ value: '', label: '全部' });
        }
      }
    }
  }

  return copy;
}

const provinceAndCityDataPlus = addAllOption(provinceAndCityData);
const regionDataPlus = addAllOption(regionData);

export {
  provinceAndCityData,
  regionData,
  provinceAndCityDataPlus,
  regionDataPlus,
  CodeToText,
  TextToCode
};
