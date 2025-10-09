export const realUnitConversion = (unit: string | number | undefined) => {
  if (unit == null || unit === '') return undefined
 return  Object.prototype.toString.call(unit) === '[object String]' ? unit : unit + 'px'
}