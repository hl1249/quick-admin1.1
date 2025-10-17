export const realUnitConversion = (unit: string | number | undefined): string | undefined => {
  if (unit == null || unit === '') return undefined;
  
  if (typeof unit === 'string') {
    // 检查字符串是否已经包含 CSS 单位
    const hasUnit = /^(auto|calc\(.*\)|[-+]?[\d.]+(px|rem|em|%|vw|vh|vmin|vmax|ex|ch|mm|cm|in|pt|pc))$/i.test(unit.trim());
    return hasUnit ? unit : unit; // 或者可以根据需要添加默认单位
  }
  
  // 数字默认添加 px 单位
  return `${unit}px`;
}