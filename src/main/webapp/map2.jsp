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
	
	/* 목록 아이템 테두리 간소화 */
	#oliveList .list-group-item {
	  border-left: none;
	  border-top: none;
	  border-right: none;
	  border-bottom: 1px solid #ddd;
  	  border-left: 1px solid #ddd;
  	  border-right: 1px solid #ddd;
	  border-radius: 0;
	}
	
	/* 목록 박스 스크롤 및 테두리 */
	#oliveList {
	  height: 500px;            /* 지도 높이와 맞춤 */
	  overflow-y: auto;         /* 세로 스크롤 자동 생성 */
	  border: none;
	  border-top: 1px solid #ddd;
	  border-radius: 0;
	}
</style>
<!-- 메인 컨테이너 -->
<div class="container py-2 d-flex flex-column align-items-center">
	<div class="row justify-content-center w-100">
		<!-- 왼쪽: 목록 -->
		<div class="col-md-3">
			<h4>목록</h4>
			<ul class="list-group" id="oliveList" style="margin-top: 20px;"></ul>
		</div>
	
		<!-- 오른쪽: 지도와 검색 옵션 -->
		<div class="col-md-9 position-relative">
			<div class="map-wrapper" style="width: 800px; margin: 0 auto;">
				<!-- 카테고리 및 지역 선택 -->
				<div class="d-flex gap-2 justify-content-end mb-3" style="background-color: transparent;">
					<select id="categorySelect" class="form-select form-select-sm" style="width: 200px; height: 32px;">
					  	<option value="전체">전체</option>
					  	<option value="생일카페">생일카페</option>
					</select>
					<select id="legionSelect" class="form-select form-select-sm" style="width: 200px; height: 32px;">
					  	<option value="홍대">홍대</option>
					  	<option value="합정">합정</option>
					</select>
					
					<!-- 검색 버튼 -->
					<button id="searchBtn" class="btn btn-sm btn-primary"
					        style="width: 80px; height: 32px; line-height: 1.5; padding: 0 10px; 
					        background-color: #0d6efd; border-color: #0d6efd;">검색</button>
				</div>
			
				<!-- 지도 -->
				<div id="map" style="width: 100%; height: 500px;"></div>
			</div>
		</div>
	</div>
</div>

<script>
//지점 데이터 (지역별, 브랜드별)
const storeData = {
	'강남': {
		'올리브영': [
			{ name: '올리브영 역삼점', lat: 37.4987564, lng: 127.0292784, address: '서울시 강남구 역삼동' },
			{ name: '올리브영 강남타운점', lat: 37.5008693, lng: 127.0256886, address: '서울시 서초구 서초동' },
			{ name: '올리브영 서초타운점', lat: 37.4950072, lng: 127.0280174, address: '서울시 서초구 서초동' },
			{ name: '올리브영 강남우성점', lat: 37.4918902, lng: 127.0309525, address: '서울시 강남구 역삼동' },
			{ name: '올리브영 서초대로점', lat: 37.4940977, lng: 127.0158607, address: '서울시 서초구 서초동' },
			{ name: '올리브영 서초우성점', lat: 37.4925811, lng: 127.0295735, address: '서울시 서초구 서초동' },
			{ name: '올리브영 강남중앙점', lat: 37.4962484, lng: 127.0287983,  address: '서울시 강남구 역삼동' },
			{ name: '올리브영 역삼중앙점', lat: 37.5010231, lng: 127.0360826,  address: '서울시 강남구 역삼동' },
			{ name: '올리브영 신강남점', lat: 37.5025179, lng: 127.0264331, address: '서울시 강남구 역삼동' },
			{ name: '올리브영 역삼역점', lat: 37.4996424, lng: 127.0342691, address: '서울시 강남구 역삼동' }
		],
		'다이소': [
			{ name: '다이소 강남본점', lat: 37.4959528, lng: 127.029101, address: '서울시 강남구 역삼동' },
			{ name: '다이소 도곡점', lat: 37.4918874, lng: 127.0399974, address: '서울시 강남구 도곡동' },
			{ name: '다이소 강남역2호점', lat: 37.4988108, lng: 127.0289974, address: '서울시 강남구 역삼동' },
			{ name: '다이소 교대역점', lat: 37.4941923, lng: 127.0165987, address: '서울시 서초구 서초동' },
			{ name: '다이소 신논현역점', lat: 37.5043512, lng: 127.0250471, address: '서울시 강남구 역삼동' }
		]
	},
  	'성수': {
    	'올리브영': [	
      		{ name: '올리브영 성수점', lat: 37.545293, lng: 127.0544791, address: '서울시 성동구 성수동2가' },
      		{ name: '올리브영N 성수', lat: 37.5441151, lng: 127.054556, address: '서울시 성동구 성수동2가' },
      		{ name: '올리브영 성수연방점', lat: 37.5416089, lng: 127.056905, address: '서울시 성동구 성수동2가' },
      		{ name: '올리브영 뚝섬역점', lat: 37.5477141, lng: 127.0452712, address: '서울시 성동구 성수동1가' },
      		{ name: '올리브영 서울숲역점', lat: 37.5418696, lng: 127.0449555, address: '서울시 성동구 성수동1가' },
      		{ name: '올리브영 건대커먼그라운드점', lat: 37.5411513, lng: 127.0659498, address: '서울시 광진구 자양동' }      
		],
		'다이소': [
      		{ name: '다이소 뚝섬역점', lat: 37.5477545, lng: 127.0451425, address: '서울시 성동구 성수동1가' },
      		{ name: '다이소 건대입구점', lat: 37.5408751	, lng: 127.0684635, address: '서울시 광진구 화양동' }
   		]
  	},
  	'홍대': {
    	'올리브영': [
      		{ name: '올리브영 홍대정문점', lat: 37.5531465, lng: 126.9240771, address: '서울시 마포구 서교동' },
      		{ name: '올리브영 홍대사거리점', lat: 37.5548763, lng: 126.9220762, address: '서울시 마포구 동교동' },
      		{ name: '올리브영 홍대타운점', lat: 37.5565733, lng: 126.9243823, address: '서울시 마포구 동교동' },
      		{ name: '올리브영 상수역점', lat: 37.5489633, lng: 126.9226304, address: '서울시 마포구 상수동' },
      		{ name: '올리브영 광흥창역점', lat: 37.5498134, lng: 126.9314523, address: '서울시 마포구 상수동' }
    	],
    	'다이소': [
	      	{ name: '다이소 홍대2호점', lat: 37.5578486, lng: 126.9255463, address: '서울시 마포구 동교동' },
      		{ name: '다이소 홍대입구점', lat: 37.5544355, lng: 126.922117, address: '서울시 마포구 동교동' },
      		{ name: '다이소 합정동점', lat: 37.5483249, lng: 126.9172999, address: '서울시 마포구 동교동' },
      		{ name: '다이소 연희동점', lat: 37.5657777, lng: 126.9298108, address: '서울시 서대문구 연희동' },
      		{ name: '다이소 신촌명물거리점', lat: 37.55825, lng: 126.9380507, address: '서울시 서대문구 창천동' },
      		{ name: '다이소 신촌본점', lat: 37.5553011, lng: 126.9355299, address: '서울시 마포구 노고산동' }
    	],
    	'생일카페': [
    		{ name: '위밋데얼', lat: 37.552881, lng: 126.921116, address: '블랙핑크 생일 카페'},
    		{ name: '카페 몽글 하늘점', lat: 37.555150, lng: 126.927174, address: 'BTS 생일 카페'},
    		{ name: '요고 프로즌요거트 홍대점', lat: 37.555348, lng: 126.928283, address: '데이식스 생일카페'},
    	]
  	},
  	'DDP': {
	    '올리브영': [
	      	{ name: '올리브영 동대문역사문화공원역점', lat: 37.5670961, lng: 127.0080856, address: '서울시 중구 을지로6가' },
      		{ name: '올리브영 현대시티아울렛동대문점', lat: 37.5689151, lng: 127.0076901, address: '서울시 중구 을지로6가' },
      		{ name: '올리브영 두타점', lat: 37.5688137, lng: 127.0087526, address: '서울시 중구 을지로6가' },
      		{ name: '올리브영 던던동대문점', lat: 37.5688137, lng: 127.0087526, address: '서울시 중구 을지로6가' },
      		{ name: '올리브영 신당역점', lat: 37.5656991, lng: 127.0164491, address: '서울시 중구 흥인동' },
      		{ name: '올리브영 제일제당센터점', lat: 37.5638908, lng: 127.0034354, address: '서울시 중구 쌍림동' }
    	],
    	'다이소': [
      		{ name: '다이소 동대문점', lat: 37.5702861, lng: 127.0099717, address: '서울시 종로구 창신동' },
      		{ name: '다이소 현대시티아울렛동대문점', lat: 37.5689569, lng: 127.0078371, address: '서울시 중구 을지로6가' },
      		{ name: '다이소 동묘점', lat: 37.573444, lng: 127.0161243, address: '서울시 종로구 숭인동' },
      		{ name: '다이소 롯데던던동대문점', lat: 37.565761, lng: 127.0069912, address: '서울시 중구 을지로6가' }
   		]
	},
	'합정': {
		'생일카페': [
			{ name: '피오니', lat: 37.550067, lng: 126.919724, address: '아이유 생일 카페'},
			{ name: '파티세리로그', lat: 37.548224, lng: 126.918845, address: '세븐틴 생일 카페'},
			{ name: '꽃뜨루', lat: 37.554870, lng: 126.910055, address: '트와이스 생일 카페'},
		]
	}
};

let map, markers = [];
let currentOpenInfo = null;

//지도 초기화
function initMap(centerLatLng) {
	if (!map) {
	  	map = new naver.maps.Map('map', {
	    	center: centerLatLng,
	    	zoom: 15,
	    	minZoom: 15,
	    	maxZoom: 16
	  	});
	} else {
	  	map.setCenter(centerLatLng);
	}
}

//모든 마커 제거
function clearMarkers() {
  	markers.forEach(({ marker }) => marker.setMap(null));
  	markers = [];
}

//마커 추가 및 InfoWindow 연결
function addMarker(store, category) {
	const position = new naver.maps.LatLng(store.lat, store.lng);
	const marker = new naver.maps.Marker({
	  	position,
	  	map,
	  	title: store.name,
	  	icon: {
	    	url: category === '올리브영' ? './resources/img/oliveyoung.png' : (category === '다이소' ? './resources/img/daiso.png' : './resources/img/free-icon-birthday-cake-2454297.png'),
	    	size: new naver.maps.Size(30, 30),
	    	scaledSize: new naver.maps.Size(30, 30),
	    	anchor: new naver.maps.Point(15, 40)
	  	}
	});

	// 정보창 생성
	const infoWindow = new naver.maps.InfoWindow({
	  	content: `
	  		<div style="padding: 10px; 
			font-size: 14px;
	       	border-radius: 10px;
	       	background-color: white;
	       	box-shadow: 0 2px 6px rgba(0,0,0,0.1);
	      	color: #000;">
	       	<strong>\${store.name}</strong><br>\${store.address}</div>`,
	  	maxWidth: 250,
	  	borderWidth: 0
	});

	// 마커 클릭 시 InfoWindow 토글
	marker.addListener('click', () => {
	  	if (currentOpenInfo === infoWindow) {
	    	infoWindow.close();
	    	currentOpenInfo = null;
	  	} else {
	    	if (currentOpenInfo) currentOpenInfo.close();
	    	infoWindow.open(map, marker);
	    	currentOpenInfo = infoWindow;
	  	}
	});

  	markers.push({ name: store.name, marker, infoWindow });
}

//지점 목록 및 마커 렌더링
function renderStores(region, category) {
	const oliveList = document.getElementById('oliveList');
	oliveList.innerHTML = '';
	clearMarkers();
	
	const categoriesToShow = category === '전체' ? ['생일카페'] : [category];
	const allStores = [];

	categoriesToShow.forEach(cat => {
		if (storeData[region][cat]) {
			storeData[region][cat].forEach(store => {
			  	allStores.push(store);
			
			 	// 목록 항목 생성
			  	const li = document.createElement('li');
			  	li.className = 'list-group-item';
			  	li.innerHTML = `
			    	<div style="font-weight: 600;">\${store.name}</div>
			    	<div style="font-size: 0.9em; color: gray;">\${store.address}</div>
			  	`;
				
			  	// 목록 클릭 시 마커 연동
			  	li.addEventListener('click', () => {
			    	const target = markers.find(m => m.name === store.name);
			    	if (target) {
			      		if (currentOpenInfo === target.infoWindow) {
			        		target.infoWindow.close();
			        		currentOpenInfo = null;
				      	} else {
				        	if (currentOpenInfo) currentOpenInfo.close();
				        		target.infoWindow.open(map, target.marker);
				        		currentOpenInfo = target.infoWindow;
				      	}
			    	}
			  });
			
			  oliveList.appendChild(li);
			  addMarker(store, cat);
			});
		}
	});

	if (allStores.length > 0) {
		  let sumLat = 0, sumLng = 0;

	  	for (let i = 0; i < allStores.length; i++) {
	    	sumLat += allStores[i].lat;
	    	sumLng += allStores[i].lng;
	  	}
	
	  	const avgLat = sumLat / allStores.length;
	  	const avgLng = sumLng / allStores.length;
	
	  	const center = new naver.maps.LatLng(avgLat, avgLng);
	  	initMap(center);
	} else {
  		oliveList.innerHTML = '<li class="list-group-item">지점이 없습니다.</li>';
	}

}

//검색 버튼 클릭 시 매장 렌더링
document.getElementById('searchBtn').addEventListener('click', () => {
	const category = document.getElementById('categorySelect').value;
	const legion = document.getElementById('legionSelect').value;
	renderStores(legion, category);
});

//초기 지도 및 목록 로딩
window.onload = function () {
	document.getElementById('categorySelect').value = '전체';
	document.getElementById('legionSelect').value = '홍대';
	const defaultCenter = new naver.maps.LatLng(37.5008693, 127.0256886);
	initMap(defaultCenter);
	renderStores('홍대', '전체');
};
</script>

