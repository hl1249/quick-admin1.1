import type { App } from 'vue'

import qaTable from './table/qaTable.vue'
import qaForm from './form/qaForm.vue'
import qaTableQuery from './table/qaTableQuery.vue'
import qaFormItem from './form/qaFormItem.vue'
import qaTreeSelect from './base/qaTreeSelect.vue'
import qaDetail from './base/qaDetail.vue'
import qaTableColumn from './base/qaTableColumn.vue'
import qaAreaCascader from './base/qaAreaCascader.vue'
import qaIconSelect from './base/qaIconSelect.vue'
import qaCascader from './base/qaCascader.vue'
import qaTableSelect from './base/qaTableSelect.vue'

export default {
  install(app: App) {
    app.component('qaTable', qaTable)
    app.component('qaForm', qaForm)
    app.component('qaTableQuery', qaTableQuery)
    app.component('qaFormItem', qaFormItem)
    app.component('qaTreeSelect', qaTreeSelect)
    app.component('qaDetail', qaDetail)
    app.component('qaTableColumn', qaTableColumn)
    app.component('qaAreaCascader', qaAreaCascader)
    app.component('qaIconSelect', qaIconSelect)
    app.component('qaCascader', qaCascader)
    app.component('qaTableSelect', qaTableSelect)
  }
}
