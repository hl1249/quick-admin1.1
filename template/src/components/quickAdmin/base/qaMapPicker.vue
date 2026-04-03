<template>
  <!-- 触发按钮 -->
  <div class="qa-map-picker">
    <el-button :disabled="disabled" @click="openPicker">
      <el-icon style="margin-right: 4px;"><Location /></el-icon>
      {{ modelValue?.name || placeholder || '选择位置' }}
    </el-button>
    <el-button
      v-if="modelValue"
      link
      type="info"
      style="margin-left: 4px;"
      :disabled="disabled"
      @click.stop="onClear"
    >
      <el-icon ><CircleClose /></el-icon>
    </el-button>
  </div>
  <div v-if="staticMapUrl" class="qa-map-static-preview">
    <img :src="staticMapUrl" class="qa-map-static-preview__img" alt="地图预览" />
    <div class="qa-map-static-preview__label">
      <el-icon :size="12" style="flex-shrink:0;"><Location /></el-icon>
      <span>{{ modelValue?.name }}</span>
    </div>
  </div>
  <!-- 全屏选择器（传送到 body） -->
  <teleport to="body">
    <transition name="qa-map-fade">
      <div v-if="visible" class="qa-map-fullscreen">

        <!-- 顶部栏 -->
        <div class="qa-map-topbar">
          <span class="qa-map-topbar__title">选择位置</span>
          <div class="qa-map-topbar__actions">
            <el-button @click="closePicker">取消</el-button>
            <el-button
              type="primary"
              :disabled="!pendingValue"
              :loading="confirming"
              @click="onConfirm"
            >
              确认
            </el-button>
          </div>
        </div>

        <!-- 地图主体 -->
        <div class="qa-map-body">
          <div id="qa-map-fs-container"></div>

          <!-- 搜索面板 -->
          <div class="qa-map-panel">
            <div class="qa-map-panel__search">
              <el-icon class="qa-map-panel__search-icon"><Search /></el-icon>
              <input
                v-model="keyword"
                class="qa-map-panel__input"
                placeholder="搜索地点"
                @input="onSearch"
              />
              <el-icon
                v-if="keyword"
                class="qa-map-panel__clear"
                @click="clearKeyword"
              >
                <CircleClose />
              </el-icon>
            </div>

            <!-- 列表与哨兵必须在同一滚动容器内，IntersectionObserver 的 root 才能随下拉触发 -->
            <div
              ref="listScrollRef"
              class="qa-map-panel__scroll"
              @scroll.passive="onListScroll"
            >
              <ul class="qa-map-panel__list">
                <li
                  v-for="item in list"
                  :key="item.id"
                  class="qa-map-panel__item"
                  :class="{ 'is-active': isListItemHighlighted(item) }"
                  @click="selectPlace(item)"
                >
                  <div class="qa-map-panel__item-main">
                    <div class="qa-map-panel__item-header">
                      <span class="qa-map-panel__item-name">{{ item.title }}</span>
                      <span v-if="item._distance" class="qa-map-panel__item-dist">
                        {{ formatDistance(item._distance) }}
                      </span>
                    </div>
                    <div v-if="item.category" class="qa-map-panel__item-tag">{{ item.category }}</div>
                    <div class="qa-map-panel__item-addr">{{ item.address }}</div>
                  </div>
                  <div
                    v-if="isListItemHighlighted(item)"
                    class="qa-map-panel__item-check"
                    aria-hidden="true"
                  >
                    <el-icon :size="20"><CircleCheck /></el-icon>
                  </div>
                </li>
              </ul>

              <div v-if="loading && list.length === 0" class="qa-map-panel__tip">
                <el-icon class="is-loading"><Loading /></el-icon> 加载中...
              </div>
              <div v-else-if="!loading && list.length === 0" class="qa-map-panel__tip">
                暂无附近地点
              </div>

              <div class="qa-map-panel__sentinel">
                <span v-if="loadingMore">
                  <el-icon class="is-loading"><Loading /></el-icon> 加载中...
                </span>
              </div>
            </div>
          </div>

          <!-- 中心十字 / Pin -->
          <div class="qa-map-pin">
            <div class="qa-map-pin__dot"></div>
            <div class="qa-map-pin__shadow"></div>
          </div>

          <!-- 定位到当前位置按钮 -->
          <button class="qa-map-locate-btn" :class="{ 'is-locating': locating }" :disabled="locating" @click="locateMe" title="定位到当前位置">
            <el-icon :class="{ 'is-loading': locating }">
              <Aim v-if="!locating" />
              <Loading v-else />
            </el-icon>
          </button>
        </div>

        <!-- 底部预览 -->
        <div class="qa-map-bottom">
          <div class="qa-map-bottom__info">
            <el-icon color="var(--el-color-primary)" :size="16"><Location /></el-icon>
            <div class="qa-map-bottom__texts">
              <span class="qa-map-bottom__name">{{ pendingValue?.name || '移动地图或搜索以选择位置' }}</span>
              <span v-if="pendingValue?.formatted_address" class="qa-map-bottom__addr">
                {{ pendingValue.formatted_address }}
              </span>
            </div>
          </div>
          <div v-if="geoLoading" class="qa-map-bottom__loading">
            <el-icon class="is-loading"><Loading /></el-icon>
          </div>
        </div>

      </div>
    </transition>
  </teleport>
</template>

<script setup lang="ts">
import { ref, computed, watch, nextTick } from 'vue'
import { Location, CircleClose, Search, Loading, CircleCheck, Aim } from '@element-plus/icons-vue'

/* ---------- 类型 ---------- */
export interface AreaItem {
  code: string
  name: string
}

export interface MapValue {
  name: string
  address: string
  latitude: number
  longitude: number
  formatted_address: string
  province: AreaItem
  city: AreaItem
  area: AreaItem
}

/* ---------- Props ---------- */
const props = withDefaults(
  defineProps<{
    modelValue?: MapValue | null
    placeholder?: string
    disabled?: boolean
    mapKey?: string
    defaultLocation?: { latitude: number; longitude: number }
  }>(),
  {
    mapKey: '3BEBZ-LRPW6-RFTS5-MVFDZ-GN7JV-XSFKZ',
  }
)

const emit = defineEmits<{
  'update:modelValue': [val: MapValue | null]
}>()

/* ---------- 静态地图预览 ---------- */
const staticMapUrl = computed(() => {
  const v = props.modelValue
  if (!v?.latitude || !v?.longitude) return ''
  const lat = v.latitude
  const lng = v.longitude
  return (
    `https://apis.map.qq.com/ws/staticmap/v2/` +
    `?key=${props.mapKey}` +
    `&size=320*160` +
    `&center=${lat},${lng}` +
    `&zoom=15` +
    `&markers=color:red|label:A|${lat},${lng}`
  )
})

/* ---------- 状态 ---------- */
const visible = ref(false)
const keyword = ref('')
const list = ref<any[]>([])
const loading = ref(false)
const loadingMore = ref(false)
const hasMore = ref(true)
const currentPage = ref(1)
const listScrollRef = ref<HTMLElement | null>(null)
const geocodePois = ref<any[]>([])
const selectedId = ref<string | null>(null)
const pendingValue = ref<MapValue | null>(null)
const geoLoading = ref(false)
const confirming = ref(false)
const locating = ref(false)

let mapInstance: any = null
let myLocationMarker: any = null
let currentLat: number | null = null
let currentLng: number | null = null
let searchTimer: ReturnType<typeof setTimeout> | null = null
let geoTimer: ReturnType<typeof setTimeout> | null = null
const PAGE_SIZE = 20
/** 逆地理 POI 分页须固定 policy，否则翻页结果不稳定 */
const GEO_POI_POLICY = 3
/** 底部逆地理 POI 参数与右侧附近列表保持一致 */
const RGEO_NEAR_RADIUS_M = 3000
const RGEO_NEAR_POI_POLICY = 3
/** 地图中心与列表 POI 距离小于此值（米）视为同一地点，用于右侧高亮 */
const LIST_CENTER_MATCH_M = 80
/** 附近列表临时失败后的重试间隔，避免限频时直接跳页 */
const PLACES_RETRY_MS = 1100
const PROGRAMMATIC_MOVE_MATCH_M = 5
const PROGRAMMATIC_MOVE_TTL_MS = 1500
let placesRequestSeq = 0
let programmaticMoveTarget: { lat: number; lng: number; expiresAt: number } | null = null

function sleepMs(ms: number) {
  return new Promise<void>((r) => setTimeout(r, ms))
}

function createPlacesRequestSeq() {
  placesRequestSeq += 1
  return placesRequestSeq
}

function isPlacesRequestActive(requestSeq: number) {
  return visible.value && requestSeq === placesRequestSeq
}

function isProgrammaticMapMove(lat: number, lng: number) {
  if (!programmaticMoveTarget) return false
  const isExpired = Date.now() > programmaticMoveTarget.expiresAt
  if (isExpired) {
    programmaticMoveTarget = null
    return false
  }
  const matched =
    calcDistance(lat, lng, programmaticMoveTarget.lat, programmaticMoveTarget.lng) <=
    PROGRAMMATIC_MOVE_MATCH_M
  if (matched) {
    programmaticMoveTarget = null
  }
  return matched
}

function getPlaceMergeKey(item: any) {
  if (item?.id != null && item.id !== '') return String(item.id)
  const lat = item?.location?.lat ?? ''
  const lng = item?.location?.lng ?? ''
  return [
    item?.title ?? '',
    item?.address ?? '',
    lat,
    lng,
  ].join('__')
}

function normalizePoisForList(rows: any[], lat: number, lng: number) {
  return rows.map((p: any) => {
    const item = { ...p }
    if (item.location) {
      item._distance = calcDistance(lat, lng, item.location.lat, item.location.lng)
    }
    if (item.id == null || item.id === '') {
      item.id = getPlaceMergeKey(item)
    }
    return item
  })
}

function mergePlaceLists(...groups: any[][]) {
  const merged: any[] = []
  const seen = new Set<string>()
  for (const group of groups) {
    for (const item of group) {
      const key = getPlaceMergeKey(item)
      if (seen.has(key)) continue
      seen.add(key)
      merged.push(item)
    }
  }
  return merged
}

const mapCenterLat = ref<number | null>(null)
const mapCenterLng = ref<number | null>(null)

const highlightedListId = computed(() => {
  const lat = mapCenterLat.value
  const lng = mapCenterLng.value
  if (lat == null || lng == null) return null

  if (selectedId.value != null) {
    return selectedId.value
  }

  const firstItem = list.value[0]
  const loc = firstItem?.location
  if (!firstItem || !loc) return null

  const d = calcDistance(lat, lng, loc.lat, loc.lng)
  return d <= LIST_CENTER_MATCH_M ? firstItem.id : null
})

function isListItemHighlighted(item: any): boolean {
  const h = highlightedListId.value
  if (h == null) return false
  return h === item.id || String(h) === String(item.id)
}

/* ---------- 打开 / 关闭 ---------- */
function openPicker() {
  if (props.disabled) return
  visible.value = true
  nextTick(initMapScript)
}

function closePicker() {
  visible.value = false
}

function onClear() {
  emit('update:modelValue', null)
}

/* ---------- 当前位置标记 ---------- */
const MY_LOCATION_SVG = encodeURIComponent(
  `<svg xmlns="http://www.w3.org/2000/svg" width="28" height="28" viewBox="0 0 28 28">` +
  `<circle cx="14" cy="14" r="13" fill="rgba(66,133,244,0.18)" stroke="#4285F4" stroke-width="1.5"/>` +
  `<circle cx="14" cy="14" r="6" fill="#4285F4" stroke="#fff" stroke-width="2.5"/>` +
  `</svg>`
)

function setMyLocationMarker(lat: number, lng: number) {
  const qq = (window as any).qq
  if (!qq?.maps || !mapInstance) return
  const latlng = new qq.maps.LatLng(lat, lng)
  if (myLocationMarker) {
    myLocationMarker.setPosition(latlng)
    myLocationMarker.setVisible(true)
    return
  }
  myLocationMarker = new qq.maps.Marker({
    position: latlng,
    map: mapInstance,
    icon: new qq.maps.MarkerImage(
      `data:image/svg+xml;charset=UTF-8,${MY_LOCATION_SVG}`,
      new qq.maps.Size(28, 28),
      new qq.maps.Point(0, 0),
      new qq.maps.Point(14, 14),
    ),
    title: '我的位置',
    zIndex: 200,
  })
}

function clearMyLocationMarker() {
  if (myLocationMarker) {
    myLocationMarker.setMap(null)
    myLocationMarker = null
  }
}

async function locateMe() {
  if (!mapInstance || locating.value) return
  locating.value = true
  try {
    const pos = await getGPSPosition()
    const qq = (window as any).qq
    programmaticMoveTarget = {
      lat: pos.lat,
      lng: pos.lng,
      expiresAt: Date.now() + PROGRAMMATIC_MOVE_TTL_MS,
    }
    mapInstance.setCenter(new qq.maps.LatLng(pos.lat, pos.lng))
    setMyLocationMarker(pos.lat, pos.lng)
    selectedId.value = null
    currentLat = pos.lat
    currentLng = pos.lng
    mapCenterLat.value = pos.lat
    mapCenterLng.value = pos.lng

    const seq = createPlacesRequestSeq()
    currentPage.value = 1
    hasMore.value = true
    loadingMore.value = false
    geocodePois.value = []
    list.value = []
    scrollListToTop()
    loading.value = true
    reverseGeocode(pos.lat, pos.lng, '').finally(() => {
      if (isPlacesRequestActive(seq)) loading.value = false
    })
  } finally {
    locating.value = false
  }
}

/* ---------- 地图脚本加载 ---------- */
let mapScriptReady = false

function initMapScript() {
  if ((window as any).qq?.maps) {
    initMap()
    return
  }
  if (mapScriptReady) return
  mapScriptReady = true

  const cb = '__qa_map_ready__'
  ;(window as any)[cb] = () => {
    delete (window as any)[cb]
    initMap()
  }
  const script = document.createElement('script')
  script.src = `https://map.qq.com/api/js?v=2.exp&libraries=geometry&key=${props.mapKey}&callback=${cb}`
  document.body.appendChild(script)
}

async function initMap() {
  const container = document.getElementById('qa-map-fs-container')
  if (!container) return

  const pos = await getGPSPosition()
  const initLat = props.modelValue?.latitude ?? props.defaultLocation?.latitude ?? pos.lat
  const initLng = props.modelValue?.longitude ?? props.defaultLocation?.longitude ?? pos.lng

  const qq = (window as any).qq
  mapInstance = new qq.maps.Map(container, {
    center: new qq.maps.LatLng(initLat, initLng),
    zoom: 15,
    panControl: false,
    zoomControl: false,
    mapTypeControl: false,
  })

  qq.maps.event.addListener(mapInstance, 'dragend', onMapMoved)
  qq.maps.event.addListener(mapInstance, 'zoomend', onMapMoved)

  setTimeout(onMapMoved, 300)
}

/** 浏览器定位为 WGS84，腾讯地图与 geocoder 等为 GCJ-02，须经 WebService 转换 */
function translateWgs84ToGcj02(lat: number, lng: number): Promise<{ lat: number; lng: number }> {
  return new Promise((resolve) => {
    const cb = '__qa_coord_' + Date.now()
    const script = document.createElement('script')
    ;(window as any)[cb] = (res: any) => {
      delete (window as any)[cb]
      script.remove()
      const loc = res?.status === 0 && Array.isArray(res.locations) ? res.locations[0] : null
      if (loc && typeof loc.lat === 'number' && typeof loc.lng === 'number') {
        resolve({ lat: loc.lat, lng: loc.lng })
      } else {
        resolve({ lat, lng })
      }
    }
    script.onerror = () => {
      delete (window as any)[cb]
      script.remove()
      resolve({ lat, lng })
    }
    script.src =
      `https://apis.map.qq.com/ws/coord/v1/translate` +
      `?type=1` +
      `&locations=${lat},${lng}` +
      `&key=${props.mapKey}` +
      `&output=jsonp&callback=${cb}`
    document.body.appendChild(script)
  })
}

function getGPSPosition(): Promise<{ lat: number; lng: number }> {
  return new Promise((resolve) => {
    if (!navigator.geolocation) return resolve({ lat: 30.2741, lng: 120.1551 })
    navigator.geolocation.getCurrentPosition(
      (p) => {
        void translateWgs84ToGcj02(p.coords.latitude, p.coords.longitude).then(resolve)
      },
      () => resolve({ lat: 30.2741, lng: 120.1551 }),
      { timeout: 6000, maximumAge: 60000 }
    )
  })
}

/* ---------- 地图移动 ---------- */
function onMapMoved() {
  if (!mapInstance) return
  const c = mapInstance.getCenter()
  const lat = c.getLat()
  const lng = c.getLng()
  mapCenterLat.value = lat
  mapCenterLng.value = lng
  if (isProgrammaticMapMove(lat, lng)) return
  selectedId.value = null
  currentLat = lat
  currentLng = lng

  // 防抖：停止移动 400ms 后用一次 geocoder 同时完成逆地理编码 + 附近列表
  if (geoTimer) clearTimeout(geoTimer)
  geoTimer = setTimeout(() => {
    const seq = createPlacesRequestSeq()
    currentPage.value = 1
    hasMore.value = true
    loadingMore.value = false
    geocodePois.value = []
    list.value = []
    scrollListToTop()
    loading.value = true
    reverseGeocode(lat, lng, '').finally(() => {
      if (isPlacesRequestActive(seq)) loading.value = false
    })
  }, 400)
}

/* ---------- 逆地理失败时仍允许选点（省市区为空）---------- */
function applyGeocodeFallback(lat: number, lng: number, placeName: string, placeAddr?: string) {
  const empty: AreaItem = { code: '', name: '' }
  pendingValue.value = {
    name: placeName || '地图选点',
    address: placeAddr ?? '',
    latitude: lat,
    longitude: lng,
    formatted_address: '',
    province: empty,
    city: empty,
    area: empty,
  }
}

/* ---------- JSONP 逆地理编码（获取省市区代码）---------- */
function reverseGeocode(lat: number, lng: number, placeName: string, placeAddr?: string, updateList = true) {
  geoLoading.value = true
  return new Promise<void>((resolve) => {
    const cb = '__qa_rgeo_' + Date.now()
    const script = document.createElement('script')

    ;(window as any)[cb] = (res: any) => {
      delete (window as any)[cb]
      script.remove()
      geoLoading.value = false

      if (res?.status === 0 && res.result) {
        const r = res.result
        const adcode: string = r.ad_info?.adcode ?? ''
        const province = r.ad_info?.province ?? r.address_component?.province ?? ''
        const city = r.ad_info?.city ?? r.address_component?.city ?? ''
        const district = r.ad_info?.district ?? r.address_component?.district ?? ''
        const pois = Array.isArray(r.pois) ? normalizePoisForList(r.pois, lat, lng) : []

        const provinceCode = adcode ? adcode.slice(0, 2) + '0000' : ''
        const cityCode = adcode ? adcode.slice(0, 4) + '00' : ''
        const areaCode = adcode

        const nearestPoi = pois.length ? pois[0] : null
        // name：已选点 > 最近周边 POI > 推荐描述
        const name =
          placeName ||
          nearestPoi?.title ||
          r.formatted_addresses?.recommend ||
          r.address ||
          ''
        // address：已选地址 > 最近 POI 地址 > 区
        const address = placeAddr ?? nearestPoi?.address ?? district

        pendingValue.value = {
          name,
          address,
          latitude: lat,
          longitude: lng,
          formatted_address: r.address ?? '',
          province: { code: provinceCode, name: province },
          city: { code: cityCode, name: city },
          area: { code: areaCode, name: district },
        }
        if (updateList) {
          geocodePois.value = pois
          if (visible.value && !keyword.value.trim()) {
            list.value = mergePlaceLists(pois)
            hasMore.value = pois.length > 0
          }
        }
      } else if (res?.status === 120) {
        // Key 每秒请求量已达上限：仍写入坐标与名称，确认可用；省市区需业务侧容忍为空
        applyGeocodeFallback(lat, lng, placeName, placeAddr)
      }
      resolve()
    }

    script.onerror = () => {
      delete (window as any)[cb]
      script.remove()
      geoLoading.value = false
      resolve()
    }

    script.src =
      `https://apis.map.qq.com/ws/geocoder/v1/` +
      `?location=${lat},${lng}` +
      `&key=${props.mapKey}` +
      `&get_poi=1` +
      `&poi_options=radius=${RGEO_NEAR_RADIUS_M};page_size=${PAGE_SIZE};page_index=1;policy=${RGEO_NEAR_POI_POLICY}` +
      `&output=jsonp&callback=${cb}`

    document.body.appendChild(script)
  })
}

/* ---------- 搜索 & 分页 ---------- */
type PlacesOnceResult =
  | { kind: 'ok'; rows: any[] }
  | { kind: 'retryable_error'; status?: number }

function fetchPlacesOnce(kw: string, lat: number, lng: number, page: number): Promise<PlacesOnceResult> {
  return new Promise((resolve) => {
    const cb = '__qa_place_' + Date.now()
    const script = document.createElement('script')

    ;(window as any)[cb] = (res: any) => {
      delete (window as any)[cb]
      script.remove()
      const status = Number(res?.status)
      if (status === 0) {
        const raw: any[] = Array.isArray(res.data)
          ? res.data
          : Array.isArray(res.result?.pois)
            ? res.result.pois
            : []
        resolve({
          kind: 'ok',
          rows: raw.map((p: any) => {
            if (p.location) {
              p._distance = calcDistance(lat, lng, p.location.lat, p.location.lng)
            }
            return p
          }),
        })
        return
      }
      // 非 0 状态（包含 key 失效、限频等）一律视为临时失败，避免误判为“没有更多”
      resolve({ kind: 'retryable_error', status })
    }

    script.onerror = () => {
      delete (window as any)[cb]
      script.remove()
      resolve({ kind: 'retryable_error' })
    }

    if (kw?.trim()) {
      script.src =
        `https://apis.map.qq.com/ws/place/v1/search` +
        `?keyword=${encodeURIComponent(kw.trim())}` +
        `&boundary=nearby(${lat},${lng},3000)` +
        `&orderby=_distance` +
        `&page_size=${PAGE_SIZE}` +
        `&page_index=${page}` +
        `&key=${props.mapKey}` +
        `&output=jsonp&callback=${cb}`
    } else {
      script.src =
        `https://apis.map.qq.com/ws/geocoder/v1/` +
        `?output=jsonp` +
        `&key=${props.mapKey}` +
        `&location=${lat},${lng}` +
        `&get_poi=1` +
        `&poi_options=page_size=${PAGE_SIZE};page_index=${page};radius=3000;policy=${GEO_POI_POLICY}` +
        `&callback=${cb}`
    }

    document.body.appendChild(script)
  })
}

async function fetchPlaces(kw: string, lat: number, lng: number, page = 1, requestSeq: number): Promise<any[] | null> {
  while (isPlacesRequestActive(requestSeq)) {
    const r = await fetchPlacesOnce(kw, lat, lng, page)
    if (!isPlacesRequestActive(requestSeq)) return null
    if (r.kind === 'ok') return r.rows
    await sleepMs(PLACES_RETRY_MS + Math.floor(Math.random() * 400))
  }
  return null
}

function isScrolledToBottom(root: HTMLElement) {
  return root.scrollTop + root.clientHeight >= root.scrollHeight - 2
}

function onListScroll() {
  const root = listScrollRef.value
  if (!root || !isScrolledToBottom(root)) return
  void loadMore()
}

function scrollListToTop() {
  if (listScrollRef.value) {
    listScrollRef.value.scrollTop = 0
  }
}

async function loadFirst(lat: number, lng: number) {
  const requestSeq = createPlacesRequestSeq()
  currentLat = lat
  currentLng = lng
  currentPage.value = 1
  hasMore.value = true
  loadingMore.value = false
  loading.value = true
  geocodePois.value = []
  scrollListToTop()
  try {
    const data = await fetchPlaces(keyword.value, lat, lng, 1, requestSeq)
    if (!isPlacesRequestActive(requestSeq) || data === null) return
    list.value = keyword.value.trim()
      ? mergePlaceLists(data)
      : mergePlaceLists(geocodePois.value, data)
    hasMore.value = data.length > 0
  } finally {
    if (isPlacesRequestActive(requestSeq)) {
      loading.value = false
    }
  }
}

async function loadMore() {
  if (loadingMore.value || loading.value || !hasMore.value || currentLat === null || currentLng === null) return
  const requestSeq = placesRequestSeq
  if (!isPlacesRequestActive(requestSeq)) return
  loadingMore.value = true
  const nextPage = currentPage.value + 1
  try {
    const data = await fetchPlaces(keyword.value, currentLat!, currentLng!, nextPage, requestSeq)
    if (!isPlacesRequestActive(requestSeq) || data === null) return
    currentPage.value = nextPage
    hasMore.value = data.length > 0
    if (data.length) {
      // 无关键词走 geocoder/v1，直接追加不去重
      list.value = keyword.value.trim()
        ? mergePlaceLists(list.value, data)
        : [...list.value, ...data]
    }
  } finally {
    if (isPlacesRequestActive(requestSeq)) {
      loadingMore.value = false
    }
  }
}

function onSearch() {
  if (searchTimer) clearTimeout(searchTimer)
  searchTimer = setTimeout(() => {
    if (!mapInstance) return
    const c = mapInstance.getCenter()
    loadFirst(c.getLat(), c.getLng())
  }, 300)
}

function clearKeyword() {
  keyword.value = ''
  onSearch()
}

/* ---------- 点击搜索结果 ---------- */
async function selectPlace(item: any) {
  const { lat, lng } = item.location
  selectedId.value = item.id
  mapCenterLat.value = lat
  mapCenterLng.value = lng

  const qq = (window as any).qq
  programmaticMoveTarget = {
    lat,
    lng,
    expiresAt: Date.now() + PROGRAMMATIC_MOVE_TTL_MS,
  }
  mapInstance.setCenter(new qq.maps.LatLng(lat, lng))

  // 用逆地理编码填充省市区代码，不更新右侧列表
  await reverseGeocode(lat, lng, item.title, item.address, false)
}

/* ---------- 确认 ---------- */
async function onConfirm() {
  if (!pendingValue.value) return
  emit('update:modelValue', { ...pendingValue.value })
  closePicker()
}

/* ---------- 工具 ---------- */
function calcDistance(lat1: number, lng1: number, lat2: number, lng2: number) {
  const r = Math.PI / 180
  const a = (lat1 - lat2) * r
  const b = (lng1 - lng2) * r
  return Math.round(
    2 * Math.asin(
      Math.sqrt(
        Math.sin(a / 2) ** 2 +
        Math.cos(lat1 * r) * Math.cos(lat2 * r) * Math.sin(b / 2) ** 2
      )
    ) * 6378137
  )
}

function formatDistance(d: number) {
  return d < 1000 ? `${d}m` : `${(d / 1000).toFixed(1)}km`
}

/* ---------- 关闭时清理 ---------- */
watch(visible, (val) => {
  if (!val) {
    createPlacesRequestSeq()
    clearMyLocationMarker()
    mapInstance = null
    programmaticMoveTarget = null
    list.value = []
    geocodePois.value = []
    keyword.value = ''
    pendingValue.value = null
    selectedId.value = null
    mapCenterLat.value = null
    mapCenterLng.value = null
    loading.value = false
    loadingMore.value = false
    hasMore.value = true
    if (geoTimer) clearTimeout(geoTimer)
    if (searchTimer) clearTimeout(searchTimer)
  }
})
</script>

<style scoped>
/* ---------- 触发区域 ---------- */
.qa-map-picker {
  align-items: center;
}

/* ---------- 全屏遮罩 ---------- */
.qa-map-fullscreen {
  position: fixed;
  inset: 0;
  z-index: 9999;
  display: flex;
  flex-direction: column;
  background: #000;
}

/* ---------- 顶部栏 ---------- */
.qa-map-topbar {
  position: relative;
  z-index: 10;
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 0 16px;
  height: 52px;
  background: #fff;
  box-shadow: 0 1px 4px rgba(0, 0, 0, 0.12);
  flex-shrink: 0;
}

.qa-map-topbar__title {
  font-size: 16px;
  font-weight: 600;
  color: #1a1a1a;
}

.qa-map-topbar__actions {
  display: flex;
  gap: 8px;
}

/* ---------- 地图主体 ---------- */
.qa-map-body {
  flex: 1;
  position: relative;
  overflow: hidden;
}

#qa-map-fs-container {
  width: 100%;
  height: 100%;
}

/* ---------- 搜索面板 ---------- */
.qa-map-panel {
  position: absolute;
  top: 12px;
  right: 12px;
  width: 300px;
  max-height: calc(100% - 24px);
  background: #fff;
  border-radius: 10px;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.18);
  display: flex;
  flex-direction: column;
  overflow: hidden;
  z-index: 100;
}

.qa-map-panel__search {
  display: flex;
  align-items: center;
  padding: 0 12px;
  height: 44px;
  border-bottom: 1px solid #f0f0f0;
  flex-shrink: 0;
  gap: 8px;
}

.qa-map-panel__search-icon {
  color: #bbb;
  flex-shrink: 0;
}

.qa-map-panel__input {
  flex: 1;
  border: none;
  outline: none;
  font-size: 14px;
  color: #333;
  background: transparent;
}

.qa-map-panel__input::placeholder {
  color: #c0c4cc;
}

.qa-map-panel__clear {
  cursor: pointer;
  color: #c0c4cc;
  flex-shrink: 0;
}

.qa-map-panel__clear:hover {
  color: #909399;
}

.qa-map-panel__scroll {
  flex: 1;
  min-height: 0;
  overflow-y: auto;
  display: flex;
  flex-direction: column;
}

.qa-map-panel__list {
  list-style: none;
  margin: 0;
  padding: 0;
  flex-shrink: 0;
}

.qa-map-panel__item {
  display: flex;
  align-items: flex-start;
  gap: 8px;
  padding: 10px 14px;
  cursor: pointer;
  border-bottom: 1px solid #f7f7f7;
  transition: background 0.15s;
}

.qa-map-panel__item-main {
  flex: 1;
  min-width: 0;
}

.qa-map-panel__item-check {
  flex-shrink: 0;
  color: var(--el-color-primary);
  line-height: 1;
  padding-top: 1px;
}

.qa-map-panel__item:hover,
.qa-map-panel__item.is-active {
  background: #f0f7ff;
}

.qa-map-panel__item-header {
  display: flex;
  align-items: baseline;
  justify-content: space-between;
  gap: 8px;
  margin-bottom: 3px;
}

.qa-map-panel__item-name {
  font-size: 14px;
  font-weight: 500;
  color: #222;
  flex: 1;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.qa-map-panel__item.is-active .qa-map-panel__item-name {
  color: var(--el-color-primary);
}

.qa-map-panel__item-dist {
  font-size: 11px;
  color: #52c41a;
  white-space: nowrap;
  flex-shrink: 0;
}

.qa-map-panel__item-tag {
  display: inline-block;
  font-size: 10px;
  color: var(--el-color-primary);
  background: #e6f4ff;
  padding: 1px 6px;
  border-radius: 3px;
  margin-bottom: 3px;
}

.qa-map-panel__item-addr {
  font-size: 12px;
  color: #aaa;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.qa-map-panel__tip {
  text-align: center;
  padding: 20px 0;
  color: #bbb;
  font-size: 13px;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 6px;
}

.qa-map-panel__sentinel {
  text-align: center;
  padding: 8px;
  font-size: 12px;
  color: #ccc;
  min-height: 28px;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 6px;
  flex-shrink: 0;
}

/* ---------- 中心 Pin ---------- */
.qa-map-pin {
  position: absolute;
  left: 50%;
  top: 50%;
  transform: translate(-50%, -100%);
  pointer-events: none;
  z-index: 50;
  display: flex;
  flex-direction: column;
  align-items: center;
}

.qa-map-pin__dot {
  width: 22px;
  height: 22px;
  border-radius: 50% 50% 50% 0;
  background: var(--el-color-primary);
  transform: rotate(-45deg);
  box-shadow: 0 2px 6px rgba(0, 0, 0, 0.3);
}

.qa-map-pin__shadow {
  width: 10px;
  height: 5px;
  background: rgba(0, 0, 0, 0.2);
  border-radius: 50%;
  margin-top: 2px;
  filter: blur(2px);
}

/* ---------- 定位按钮 ---------- */
.qa-map-locate-btn {
  position: absolute;
  right: 12px;
  bottom: 16px;
  width: 40px;
  height: 40px;
  border-radius: 50%;
  background: #fff;
  border: none;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.2);
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 20px;
  color: var(--el-color-primary);
  z-index: 100;
  transition: box-shadow 0.2s, color 0.2s;
}

.qa-map-locate-btn:hover:not(:disabled) {
  box-shadow: 0 4px 14px rgba(0, 0, 0, 0.28);
  color: var(--el-color-primary-dark-2);
}

.qa-map-locate-btn:disabled {
  cursor: not-allowed;
  color: #c0c4cc;
}

.qa-map-locate-btn.is-locating {
  color: var(--el-color-primary);
}

/* ---------- 底部信息条 ---------- */
.qa-map-bottom {
  flex-shrink: 0;
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 12px 16px;
  background: #fff;
  box-shadow: 0 -1px 4px rgba(0, 0, 0, 0.08);
  min-height: 64px;
  z-index: 10;
}

.qa-map-bottom__info {
  display: flex;
  align-items: flex-start;
  gap: 8px;
  flex: 1;
  overflow: hidden;
}

.qa-map-bottom__texts {
  display: flex;
  flex-direction: column;
  overflow: hidden;
}

.qa-map-bottom__name {
  font-size: 14px;
  font-weight: 500;
  color: #222;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.qa-map-bottom__addr {
  font-size: 12px;
  color: #999;
  margin-top: 2px;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.qa-map-bottom__loading {
  color: #bbb;
  font-size: 18px;
  flex-shrink: 0;
}

/* ---------- 过渡动画 ---------- */
.qa-map-fade-enter-active,
.qa-map-fade-leave-active {
  transition: opacity 0.2s, transform 0.2s;
}

.qa-map-fade-enter-from,
.qa-map-fade-leave-to {
  opacity: 0;
  transform: translateY(20px);
}

/* ---------- Element Plus loading icon 旋转 ---------- */
.is-loading {
  animation: rotating 1s linear infinite;
}

@keyframes rotating {
  from { transform: rotate(0); }
  to { transform: rotate(360deg); }
}

/* ---------- 静态地图预览 ---------- */
.qa-map-static-preview {
  display: inline-flex;
  flex-direction: column;
  margin-top: 6px;
  border-radius: 8px;
  overflow: hidden;
  border: 1px solid #e4e7ed;
  width: 320px;
  max-width: 100%;
}

.qa-map-static-preview__img {
  width: 100%;
  height: 160px;
  object-fit: cover;
  display: block;
}

.qa-map-static-preview__label {
  display: flex;
  align-items: center;
  gap: 4px;
  padding: 6px 10px;
  font-size: 12px;
  color: #555;
  background: #f9f9f9;
  border-top: 1px solid #eee;
  overflow: hidden;
}

.qa-map-static-preview__label span {
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}
</style>
