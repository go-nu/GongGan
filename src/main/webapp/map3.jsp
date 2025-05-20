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

<%
Connection connMap = null;
PreparedStatement pstmtM = null;
ResultSet rsM = null;
Map<String, List<Map<String, Object>>> storeData = new HashMap<>();
try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    connMap = DriverManager.getConnection("jdbc:mysql://localhost:3306/fs_semi?serverTimezone=UTC", "root", "1234");

    String sqlM = "SELECT * FROM map_loc WHERE brand = ?";
    pstmtM = connMap.prepareStatement(sqlM);
    pstmtM.setString(1, "생일카페");
    rsM = pstmtM.executeQuery();

    while (rsM.next()) {
        String region = rsM.getString("region");
        Map<String, Object> item = new HashMap<>();
        item.put("name", rsM.getString("name"));
        item.put("lat", rsM.getDouble("lat"));
        item.put("lng", rsM.getDouble("lng"));
        item.put("address", rsM.getString("address"));
        storeData.putIfAbsent(region, new ArrayList<>());
        storeData.get(region).add(item);
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
const storeData = {
<%
    Iterator<Map.Entry<String, List<Map<String, Object>>>> iter = storeData.entrySet().iterator();
    while (iter.hasNext()) {
        Map.Entry<String, List<Map<String, Object>>> entry = iter.next();
        String region = entry.getKey();
        List<Map<String, Object>> stores = entry.getValue();

        out.print("  \"" + region + "\": {\n");
        out.print("    \"생일카페\": [\n");

        for (int i = 0; i < stores.size(); i++) {
            Map<String, Object> store = stores.get(i);
            out.print("      { name: \"" + store.get("name") + "\", lat: " + store.get("lat") + ", lng: " + store.get("lng") + ", address: \"" + store.get("address") + "\" }");
            if (i < stores.size() - 1) out.print(",\n"); else out.print("\n");
        }

        out.print("    ]\n");
        out.print("  }");
        if (iter.hasNext()) out.print(",\n"); else out.print("\n");
    }
%>
};

let map, markers = [];
let currentOpenInfo = null;

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

function clearMarkers() {
  	markers.forEach(({ marker }) => marker.setMap(null));
  	markers = [];
}

function addMarker(store) {
	const position = new naver.maps.LatLng(store.lat, store.lng);
	const marker = new naver.maps.Marker({
	  	position,
	  	map,
	  	title: store.name,
	  	icon: {
	    	url: './resources/img/free-icon-birthday-cake-2454297.png',
	    	size: new naver.maps.Size(30, 30),
	    	scaledSize: new naver.maps.Size(30, 30),
	    	anchor: new naver.maps.Point(15, 40)
	  	}
	});

	const infoWindow = new naver.maps.InfoWindow({
	  	content: `
	  		<div style="padding: 10px; font-size: 14px; border-radius: 10px; background-color: white; box-shadow: 0 2px 6px rgba(0,0,0,0.1); color: #000;">
	       	<strong>\${store.name}</strong><br>\${store.address}</div>`,
	  	maxWidth: 250
	});

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

function renderStores(region) {
	const oliveList = document.getElementById('oliveList');
	oliveList.innerHTML = '';
	clearMarkers();

	const stores = storeData[region]?.['생일카페'] || [];

	if (stores.length > 0) {
	  	let sumLat = 0, sumLng = 0;

	  	stores.forEach(store => {
	    	sumLat += store.lat;
	    	sumLng += store.lng;

	    	const li = document.createElement('li');
	    	li.className = 'list-group-item';
	    	li.innerHTML = `
		    	<div style="font-weight: 600;">\${store.name}</div>
		    	<div style="font-size: 0.9em; color: gray;">\${store.address}</div>`;
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
	    	addMarker(store);
	  	});

	  	const avgLat = sumLat / stores.length;
	  	const avgLng = sumLng / stores.length;
	  	initMap(new naver.maps.LatLng(avgLat, avgLng));
	} else {
  		oliveList.innerHTML = '<li class="list-group-item">지점이 없습니다.</li>';
	}
}

document.getElementById('searchBtn').addEventListener('click', () => {
	const region = document.getElementById('legionSelect').value;
	renderStores(region);
});

window.onload = function () {
	document.getElementById('legionSelect').value = '홍대';
	const defaultCenter = new naver.maps.LatLng(37.552881, 126.921116);
	initMap(defaultCenter);
	renderStores('홍대');
};
</script>
