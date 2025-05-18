<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
String id = (String) session.getAttribute("id");
%>
<script type="text/javascript"
	src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpKeyId=14z98e6lun"></script>
<html>
<head>
<link rel="stylesheet" href="./resources/css/styles.css">
<link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
<script src="./resources/js/bootstrap.bundle.min.js"></script>

<script type="text/javascript">
	// 공통 모달 호출 함수
	function showModal(message) {
	  const modal = new bootstrap.Modal(document.getElementById("alertModal"));
	  document.getElementById("alertMessage").textContent = message;
	  modal.show();
	}
	function checkForm() {
		if (!document.newWrite.subject.value) {
			showModal("제목을 입력하세요.");
			return false;
		}
		if (!document.newWrite.content.value) {
			showModal("내용을 입력하세요.");
			return false;
		}
		return true;
	}
	  let map, marker;

	    function initMap() {
	        const defaultCenter = new naver.maps.LatLng(37.5665, 126.9780); // 서울시청 좌표
	        map = new naver.maps.Map('map', {
	            center: defaultCenter,
	            zoom: 14
	        });

	        marker = new naver.maps.Marker({
	            position: defaultCenter,
	            map: map
	        });

	        // 지도 클릭 시 주소 설정
	        naver.maps.Event.addListener(map, 'click', function(e) {
	            const latlng = e.coord;
	            marker.setPosition(latlng);
	            setLatLng(latlng.lat(), latlng.lng());
	            reverseGeocode(latlng);
	        });
	    }

	    function setLatLng(lat, lng) {
	        document.getElementById("lat").value = lat;
	        document.getElementById("lng").value = lng;
	    }

	    function reverseGeocode(coord) {
	        naver.maps.Service.reverseGeocode({
	            coords: coord,
	            orders: [
	                naver.maps.Service.OrderType.ADDR,
	                naver.maps.Service.OrderType.ROAD_ADDR
	            ].join(',')
	        }, function(status, response) {
	            if (status !== naver.maps.Service.Status.OK) {
	            	 return showModal('주소를 가져올 수 없습니다.');
	            }

	            const address = response.v2.address.roadAddress || response.v2.address.jibunAddress;
	            document.getElementById("addressInput").value = address;
	            document.getElementById("location").value = address;
	        });
	    }

	    function searchAddress() {
	        const address = document.getElementById("addressInput").value;
	        if (!address.trim()) {
	        	showModal("주소를 입력하세요.");
	            return;
	        }

	        naver.maps.Service.geocode({
	            query: address
	        }, function(status, response) {
	            if (status !== naver.maps.Service.Status.OK) {
	            	return showModal('주소 검색 실패');
	            }

	            const item = response.v2.addresses[0];
	            const latlng = new naver.maps.LatLng(item.y, item.x);
	            map.setCenter(latlng);
	            marker.setPosition(latlng);
	            setLatLng(item.y, item.x);
	            document.getElementById("location").value = item.roadAddress || item.jibunAddress;
	        });
	    }

	    window.onload = function() {
	        initMap();
	        document.getElementById("searchBtn").addEventListener("click", searchAddress);
	    };
</script>
<title>Board</title>
<style>
#map {
	width: 100%;
	height: 400px;
	margin-top: 20px;
	border: 1px solid #ccc;
}
</style>
</head>

<body>
	<jsp:include page="../header.jsp" />

	<div class="main-container">
		<div class="content-wrap board-write py-5" style="margin-top: 80px;">
			<div class="container">
				<h2 class="mb-4">📝 글쓰기</h2>

				<form name="newWrite" action="./BoardWriteAction.do" method="post"
					enctype="multipart/form-data" onsubmit="return checkForm()">
					<!-- 서버에 전달할 사용자 ID (숨김) -->
					<input type="hidden" name="id" value="<%=id%>">

					<!-- 사용자에게 보여줄 ID -->
					<div class="mb-3 row">
						<label class="col-sm-2 col-form-label">작성자</label>
						<div class="col-sm-4">
							<input type="text" class="form-control" value="<%=id%>" readonly>
						</div>
					</div>

					<div class="mb-3 row">
						<label class="col-sm-2 col-form-label">제목</label>
						<div class="col-sm-6">
							<input name="subject" type="text" class="form-control"
								placeholder="제목을 입력하세요." required>
						</div>
					</div>

					<div class="mb-3 row">
						<label class="col-sm-2 col-form-label">내용</label>
						<div class="col-sm-8">
							<textarea name="content" rows="6" class="form-control"
								placeholder="내용을 입력하세요." required></textarea>
						</div>
					</div>

					<!-- 첨부파일 필드 추가 -->
					<div class="mb-3 row">
						<label class="col-sm-2 col-form-label">첨부파일</label>
						<div class="col-sm-8">
							<input type="file" name="attachment" class="form-control">
							<small class="form-text text-muted">파일 크기는 최대 10MB까지
								가능합니다.</small>
						</div>
					</div>


					<div class="mb-3 row">
						<div class="offset-sm-2 col-sm-10">
							<input type="submit" class="btn btn-primary me-2" value="등록">
							<input type="reset" class="btn btn-secondary" value="취소">
						</div>
					</div>
					<!-- 위치 선택 -->
					<!-- <div class="mb-3 row">
						<label class="col-sm-2 col-form-label">위치</label>
						<div class="col-sm-10">
							주소 입력창 + 검색 버튼
							<div class="input-group mb-2">
								<input type="text" id="addressInput" class="form-control"
									placeholder="주소 입력">
								<button type="button" id="searchBtn"
									class="btn btn-outline-secondary">검색</button>
							</div>
							지도 영역
							<div id="map"></div>

							숨겨진 좌표 및 주소값 전송용
							<input type="hidden" name="location" id="location"> <input
								type="hidden" name="lat" id="lat"> <input type="hidden"
								name="lng" id="lng">
						</div>
					</div> -->
				</form>
			</div>
		</div>
	</div>
<!-- 부트스트랩 공통 알림 모달 -->
<div class="modal fade" id="alertModal" tabindex="-1" aria-labelledby="alertModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header bg-danger text-white">
        <h5 class="modal-title" id="alertModalLabel">알림</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="닫기"></button>
      </div>
      <div class="modal-body" id="alertMessage">
        <!-- 자바스크립트에서 메시지가 삽입됩니다 -->
      </div>
      <div class="modal-footer border-0">
        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">확인</button>
      </div>
    </div>
  </div>
</div>
	<jsp:include page="../footer.jsp" />
</body>


</html>

