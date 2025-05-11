<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MAP</title>
<link rel="stylesheet" href="./resources/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpKeyId=14z98e6lun"></script>

<style>
	#map {
	  width: 100%;
	  min-width: 400px;
	  height: 600px;
	  max-width: 800px;
	}
	.list-group-item {
	  cursor: pointer;
	}
</style>
</head>
<body>

<div class="container mt-5 py-5 d-flex flex-column align-items-center">
	<!-- 검색 UI -->
	<div class="w-100 d-flex justify-content mb-3">
	  	<div class="d-flex gap-2" style="width: 50%;">
	    	<select id="categorySelect" class="form-select" style="flex: 0 0 200px;">
		      	<option value="전체">전체</option>
		      	<option value="올리브영">올리브영</option>
		      	<option value="다이소">다이소</option>
	    	</select>
			<select id="legionSelect" class="form-select" style="flex: 0 0 200px;">
		       	<option value="강남">강남</option>
		       	<option value="성수">성수</option>
		       	<option value="홍대">홍대</option>
		       	<option value="DDP">DDP</option>
	    	</select>
	    	<button id="searchBtn" class="btn btn-primary" style="flex: 0 0 80px;">검색</button>
	  	</div>
	</div>

  <!-- 리스트 + 지도 -->
  <div class="row justify-content-center w-100">
    <div class="col-md-4">
      <h4>목록</h4>
      <ul class="list-group" id="oliveList"></ul>
    </div>
    <div class="col-md-8 d-flex justify-content-center">
      <div id="map"></div>
    </div>
  </div>
</div>
<script>
  const storeData = {
    '강남': {
      '올리브영': [
        { name: '올리브영 강남역점', lat: 37.4979, lng: 127.0276 },
        { name: '올리브영 강남본점', lat: 37.5010, lng: 127.0250 },
        { name: '올리브영 강남우성점', lat: 37.5006, lng: 127.0266 },
        { name: '올리브영 강남역사거리점', lat: 37.4987, lng: 127.0261 }
      ],
      '다이소': [
        { name: '다이소 강남역점', lat: 37.4983, lng: 127.0277 },
        { name: '다이소 서초타워점', lat: 37.5016, lng: 127.0252 },
        { name: '다이소 신논현역점', lat: 37.5040, lng: 127.0256 }
      ]
    },
    '성수': {
      '올리브영': [
        { name: '올리브영 성수점', lat: 37.5444, lng: 127.0556 }
      ],
      '다이소': [
        { name: '다이소 성수점', lat: 37.5447, lng: 127.0568 }
      ]
    },
    '홍대': {
      '올리브영': [
        { name: '올리브영 홍대입구점', lat: 37.5563, lng: 126.9236 }
      ],
      '다이소': [
        { name: '다이소 홍대점', lat: 37.5571, lng: 126.9229 }
      ]
    },
    'DDP': {
      '올리브영': [
        { name: '올리브영 동대문점', lat: 37.5664, lng: 127.0090 }
      ],
      '다이소': [
        { name: '다이소 동대문점', lat: 37.5656, lng: 127.0076 }
      ]
    }
  };

  let map, markers = [];

  function initMap(centerLatLng) {
    if (!map) {
      map = new naver.maps.Map('map', {
        center: centerLatLng,
        zoom: 15
      });
    } else {
      map.setCenter(centerLatLng);
    }
  }

  function clearMarkers() {
    markers.forEach(marker => marker.setMap(null));
    markers = [];
  }

  function addMarker(store) {
    const marker = new naver.maps.Marker({
      position: new naver.maps.LatLng(store.lat, store.lng),
      map: map,
      title: store.name
    });
    markers.push(marker);
  }

  document.getElementById('searchBtn').addEventListener('click', () => {
    const category = document.getElementById('categorySelect').value;
    const legion = document.getElementById('legionSelect').value;
    const oliveList = document.getElementById('oliveList');

    // 초기화
    oliveList.innerHTML = '';
    clearMarkers();

    // 올리브영, 다이소 모두
    const categoriesToShow = category === '전체' ? ['올리브영', '다이소'] : [category];
    const allStores = [];

    categoriesToShow.forEach(cat => {
      if (storeData[legion][cat]) {
        allStores.push(...storeData[legion][cat]);
      }
    });

    if (allStores.length === 0) {
      oliveList.innerHTML = '<li class="list-group-item">지점이 없습니다.</li>';
      return;
    }

    // 중심은 첫 지점 기준
    const center = new naver.maps.LatLng(allStores[0].lat, allStores[0].lng);
    initMap(center);

    // 목록과 마커 추가
    allStores.forEach(store => {
      const li = document.createElement('li');
      li.className = 'list-group-item';
      li.textContent = store.name;
      oliveList.appendChild(li);
      addMarker(store);
    });
    
	
  });
  window.onload = function () {
	  const defaultRegion = '강남';
	  const defaultCategory = '전체';

	  const categoriesToShow = ['올리브영', '다이소'];
	  const allStores = [];

	  categoriesToShow.forEach(cat => {
	    if (storeData[defaultRegion][cat]) {
	      allStores.push(...storeData[defaultRegion][cat]);
	    }
	  });

	  if (allStores.length === 0) return;

	  // 지도 초기화
	  const center = new naver.maps.LatLng(allStores[0].lat, allStores[0].lng);
	  initMap(center);

	  // 목록 초기화
	  const oliveList = document.getElementById('oliveList');
	  oliveList.innerHTML = '';

	  allStores.forEach(store => {
	    const li = document.createElement('li');
	    li.className = 'list-group-item';
	    li.textContent = store.name;
	    oliveList.appendChild(li);
	    addMarker(store);
	  });

	  // 드롭다운도 기본값 반영
	  document.getElementById('categorySelect').value = defaultCategory;
	  document.getElementById('legionSelect').value = defaultRegion;
	};
</script>
</body>
</html>
