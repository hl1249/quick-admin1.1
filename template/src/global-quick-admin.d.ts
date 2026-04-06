export {}

declare global {
  type QaTableComponent = typeof import('@/components/quickAdmin/table/qaTable.vue')['default']
  type QaTableInstance = InstanceType<QaTableComponent>
  type Columns = import('@/components/quickAdmin/table/qaTable.vue').Columns
  type RightBtnMoreItem = import('@/components/quickAdmin/table/qaTable.vue').RightBtnMoreItem
  type DeleteRequest = import('@/components/quickAdmin/table/qaTable.vue').DeleteRequest
}
