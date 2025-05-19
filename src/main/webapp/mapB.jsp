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
<%@ page import="java.sql.*, java.util.*" %>
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


<%
	Connection connMap = null;
	PreparedStatement pstmtM = null;
	ResultSet rsM = null;

	Map<String, Map<String, List<Map<String, Object>>>> storeData = new HashMap<>();

	try {
	    Class.forName("com.mysql.cj.jdbc.Driver");
	    connMap = DriverManager.getConnection("jdbc:mysql://localhost:3306/fs_semi?serverTimezone=UTC", "root", "1234");

	    String sqlM = "SELECT * FROM bmap";
	    pstmtM = connMap.prepareStatement(sqlM);
	    rsM = pstmtM.executeQuery();

	    while (rsM.next()) {
	        String region = rsM.getString("region");
	        String brand = rsM.getString("brand");

	        Map<String, Object> item = new HashMap<>();
	        item.put("name", rsM.getString("name"));
	        item.put("lat", rsM.getDouble("lat"));
	        item.put("lng", rsM.getDouble("lng"));
	        item.put("address", rsM.getString("address"));

	        storeData.putIfAbsent(region, new HashMap<>());
	        Map<String, List<Map<String, Object>>> brandMap = storeData.get(region);
	        
	        brandMap.putIfAbsent(brand, new ArrayList<>());
	        brandMap.get(brand).add(item);
	    }

	} catch (Exception e) {
	    out.println("DB 연결 오류: " + e.getMessage());
	} finally {
	    try {
	        if (rsM != null) rsM.close();
	        if (pstmtM != null) pstmtM.close();
	        if (connMap != null) connMap.close();
	    } catch (SQLException e) {
	        out.println("연결 종료 실패: " + e.getMessage());
	    }
	}
%>


<div class="container mt-5 py-5 d-flex flex-column align-items-center">
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
					  	<option value="올리브영">올리브영</option>
					  	<option value="다이소">다이소</option>
					</select>
					<select id="legionSelect" class="form-select form-select-sm" style="width: 200px; height: 32px;">
					  	<option value="강남">강남</option>
					  	<option value="성수">성수</option>
					  	<option value="홍대">홍대</option>
					  	<option value="DDP">DDP</option>
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
<%
    Iterator<Map.Entry<String, Map<String, List<Map<String, Object>>>>> regionIter = storeData.entrySet().iterator();
    while (regionIter.hasNext()) {
        Map.Entry<String, Map<String, List<Map<String, Object>>>> regionEntry = regionIter.next();
        String region = regionEntry.getKey();
        Map<String, List<Map<String, Object>>> brandMap = regionEntry.getValue();

        out.print("  \"" + region + "\": {\n");

        Iterator<Map.Entry<String, List<Map<String, Object>>>> brandIter = brandMap.entrySet().iterator();
        while (brandIter.hasNext()) {
            Map.Entry<String, List<Map<String, Object>>> brandEntry = brandIter.next();
            String brand = brandEntry.getKey();
            List<Map<String, Object>> stores = brandEntry.getValue();

            out.print("    \"" + brand + "\": [\n");

            for (int i = 0; i < stores.size(); i++) {
                Map<String, Object> store = stores.get(i);
                out.print("      { name: \"" + store.get("name") + "\", lat: " + store.get("lat") + ", lng: " + store.get("lng") + ", address: \"" + store.get("address") + "\" }");
                if (i < stores.size() - 1) out.print(",\n"); else out.print("\n");
            }

            out.print("    ]");
            if (brandIter.hasNext()) out.print(",\n"); else out.print("\n");
        }

        out.print("  }");
        if (regionIter.hasNext()) out.print(",\n"); else out.print("\n");
    }
%>
};


let map, markers = [];
let currentOpenInfo = null;

//지도 초기화
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
	    	url: category === '올리브영' ? './resources/img/oliveyoung.png' : './resources/img/daiso.png',
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
	
	const categoriesToShow = category === '전체' ? ['올리브영', '다이소'] : [category];
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
	document.getElementById('legionSelect').value = '강남';
	const defaultCenter = new naver.maps.LatLng(37.5008693, 127.0256886);
	initMap(defaultCenter);
	renderStores('강남', '전체');
};
</script>

