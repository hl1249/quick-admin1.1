<template>
  <div class="map-picker">
    <!-- 顶部按钮 -->
    <div class="header">
      <span class="btn cancel" @click="onCancel">取消</span>
      <span class="btn confirm" @click="onConfirm">确认</span>
    </div>

    <div class="content">
      <!-- 地图 -->
      <div id="map"></div>

      <!-- 搜索面板 -->
      <div class="search-panel">
        <input
            v-model="keyword"
            placeholder="筛选附近地标"
        />
        <ul>
          <li
              v-for="item in filteredList"
              :key="item.id"
              @click="select(item)"
          >
            <div class="title">{{ item.title }}</div>
            <div class="category">{{ item.category }}</div>
            <div class="addr">{{ item.address }}</div>
            <div class="distance" v-if="item._distance">距离：{{ formatDistance(item._distance) }}</div>
          </li>
        </ul>
        <div v-if="list.length === 0 && !loading" class="empty-tip">暂无附近地标</div>
        <div
            v-else-if="list.length > 0 && filteredList.length === 0 && !loading"
            class="empty-tip"
        >
          无匹配结果，请调整关键词
        </div>
        <div v-if="loading" class="loading-tip">加载中...</div>
      </div>
      <!-- 中心点标记 -->
      <div class="center-marker"></div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'

const emit = defineEmits(['confirm', 'cancel'])

let mapInstance = null
const keyword = ref('')
const list = ref([])
const loading = ref(false)

const filteredList = computed(() => {
  const q = keyword.value.trim().toLowerCase()
  if (!q) return list.value
  return list.value.filter((p) => {
    const t = String(p.title ?? '').toLowerCase()
    const a = String(p.address ?? '').toLowerCase()
    const c = String(p.category ?? '').toLowerCase()
    return t.includes(q) || a.includes(q) || c.includes(q)
  })
})
const center = ref({ lat: '', lng: '', address: '' })

let geocoder = null

// 获取 GPS 当前位置，失败则返回默认坐标
function getGPSPosition() {
  return new Promise((resolve) => {
    if (!navigator.geolocation) {
      resolve({ lat: 30.2741, lng: 120.1551 })
      return
    }
    navigator.geolocation.getCurrentPosition(
        (pos) => resolve({ lat: pos.coords.latitude, lng: pos.coords.longitude }),
        () => resolve({ lat: 30.2741, lng: 120.1551 }),
        { timeout: 6000, maximumAge: 60000 }
    )
  })
}

// 初始化地图
onMounted(() => {
  window.__map_callback__qq = initMap

  const script = document.createElement('script')
  script.src =
      'https://map.qq.com/api/js?v=2.exp&libraries=geometry&key=3EXBZ-3NYCW-L5MRG-ONN2B-FJYR6-H7BSU&callback=__map_callback__qq'
  document.body.appendChild(script)
})

const MAP_KEY = '3EXBZ-3NYCW-L5MRG-ONN2B-FJYR6-H7BSU'

// 逆地理 get_poi 拉取附近地标（不使用 place/v1/search）
function fetchNearbyPois(lat, lng) {
  return new Promise((resolve) => {
    const cb = '__qqgeo_poi_' + Date.now()
    const script = document.createElement('script')

    window[cb] = (res) => {
      delete window[cb]
      script.remove()

      if (res && res.status === 0 && Array.isArray(res.result?.pois)) {
        const places = res.result.pois.map((place) => {
          if (place.location) {
            place._distance = getDistance(
                lat, lng,
                place.location.lat, place.location.lng
            )
          }
          return place
        })
        places.sort((a, b) => (a._distance || 0) - (b._distance || 0))
        resolve(places)
      } else {
        resolve([])
      }
    }

    script.onerror = () => {
      delete window[cb]
      script.remove()
      resolve([])
    }

    const pageSize = 20
    const policy = 4
    script.src =
        `https://apis.map.qq.com/ws/geocoder/v1/` +
        `?output=jsonp` +
        `&key=${MAP_KEY}` +
        `&location=${lat},${lng}` +
        `&get_poi=1` +
        `&poi_options=page_size=${pageSize};page_index=1;radius=1000;policy=${policy}` +
        `&callback=${cb}`

    document.body.appendChild(script)
  })
}

// 计算两点之间的距离（米）
function getDistance(lat1, lng1, lat2, lng2) {
  const radLat1 = lat1 * Math.PI / 180.0
  const radLat2 = lat2 * Math.PI / 180.0
  const a = radLat1 - radLat2
  const b = lng1 * Math.PI / 180.0 - lng2 * Math.PI / 180.0
  let s = 2 * Math.asin(Math.sqrt(Math.pow(Math.sin(a/2),2) +
      Math.cos(radLat1) * Math.cos(radLat2) * Math.pow(Math.sin(b/2),2)))
  s = s * 6378.137 // 地球半径
  s = Math.round(s * 1000) // 转换为米
  return s
}

// 格式化距离显示
function formatDistance(distance) {
  if (!distance) return ''
  if (distance < 1000) {
    return `${distance}米`
  } else {
    return `${(distance / 1000).toFixed(1)}公里`
  }
}

async function initMap() {
  const pos = await getGPSPosition()

  mapInstance = new qq.maps.Map(document.getElementById('map'), {
    center: new qq.maps.LatLng(pos.lat, pos.lng),
    zoom: 15,
    panControl: false,
    zoomControl: false,
    mapTypeControl: false
  })

  geocoder = new qq.maps.Geocoder({
    complete: (res) => {
      if (res && res.detail) center.value.address = res.detail.address
    }
  })

  qq.maps.event.addListener(mapInstance, 'dragend', updateCenter)
  qq.maps.event.addListener(mapInstance, 'zoomend', updateCenter)

  setTimeout(updateCenter, 300)
}

// 更新中心点并刷新列表
async function updateCenter() {
  const c = mapInstance.getCenter()
  const lat = c.getLat()
  const lng = c.getLng()

  center.value.lat = lat
  center.value.lng = lng

  geocoder.getAddress(c)

  loading.value = true
  const data = await fetchNearbyPois(lat, lng)
  loading.value = false
  list.value = data
}

// 点击搜索结果
function select(item) {
  const { lat, lng } = item.location
  const latLng = new qq.maps.LatLng(lat, lng)

  mapInstance.setCenter(latLng)

  center.value = {
    lat,
    lng,
    address: item.address || item.title
  }

  // 可选：在地图上添加标记
  // addMarker(latLng, item.title)
}

// 确认
function onConfirm() {
  emit('confirm', center.value)
}

// 取消
function onCancel() {
  emit('cancel')
}
</script>

<style scoped>
.map-picker {
  width: 100%;
  height: 100%;
  position: relative;
}

.header {
  position: absolute;
  top: 10px;
  left: 10px;
  right: 10px;
  display: flex;
  justify-content: space-between;
  z-index: 10;
}

.btn {
  background: #fff;
  padding: 6px 12px;
  border-radius: 4px;
  cursor: pointer;
  box-shadow: 0 2px 4px rgba(0,0,0,0.1);
}

.confirm {
  color: #1890ff;
}

.content {
  position: relative;
  width: 100%;
  height: 100%;
}

#map {
  width: 100%;
  height: 100%;
}

.search-panel {
  position: absolute;
  top: 10px;
  right: 10px;
  width: 280px;
  max-height: 70%;
  background: #fff;
  border-radius: 8px;
  border: 1px solid #e8e8e8;
  overflow-y: auto;
  z-index: 9999;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
}

.search-panel input {
  width: 100%;
  padding: 10px 12px;
  border: none;
  border-bottom: 1px solid #f0f0f0;
  font-size: 14px;
  outline: none;
}

.search-panel input:focus {
  border-bottom-color: #1890ff;
}

.search-panel ul {
  list-style: none;
  padding: 0;
  margin: 0;
}

.search-panel li {
  padding: 12px;
  cursor: pointer;
  border-bottom: 1px solid #f5f5f5;
  transition: background 0.2s;
}

.search-panel li:hover {
  background: #f5f7fa;
}

.title {
  font-size: 15px;
  font-weight: 500;
  color: #333;
  margin-bottom: 4px;
}

.category {
  font-size: 11px;
  color: #1890ff;
  margin-bottom: 4px;
  display: inline-block;
  background: #e6f7ff;
  padding: 2px 6px;
  border-radius: 3px;
}

.addr {
  font-size: 12px;
  color: #999;
  margin-bottom: 4px;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.distance {
  font-size: 11px;
  color: #52c41a;
}

.empty-tip, .loading-tip {
  text-align: center;
  padding: 20px;
  color: #999;
  font-size: 13px;
}

.center-marker {
  position: absolute;
  top: 50%;
  left: 50%;
  width: 24px;
  height: 24px;
  background: url('https://mapapi.qq.com/web/lbs/javascriptGL/demo/img/markerDefault.png')
  no-repeat center;
  background-size: contain;
  transform: translate(-50%, -100%);
  pointer-events: none;
  z-index: 1;
}
</style>