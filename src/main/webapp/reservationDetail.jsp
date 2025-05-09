<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<title>예약 상세 페이지</title>
<link rel="stylesheet" href="./resources/css/index_style.css">
<link rel="stylesheet" href="./resources/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<script src="./resources/js/bootstrap.bundle.min.js"></script>
<style>
.main-image {
	width: 100%; 
	height: auto;
}

.carousel-item img {
	width: 100%; 
	height: 200px;
	object-fit: cover;
}
/* 이미지 스타일 */
#detailCarousel .carousel-item img {
  height: 200px;
  object-fit: cover;
  width: calc(25% - 0.5rem);
}

/* 슬라이드 안쪽 flex wrapper */
.custom-carousel-inner {
  padding: 0 3rem; /* 기본 padding (넓은 화면) */
}

/* 작은 화면일 때는 padding 제거 */
@media (max-width: 1199.98px) {
  .custom-carousel-inner {
    padding: 0 3rem;
  }
}

/* 슬라이드 넘침 방지 */
.carousel-inner {
  overflow-x: hidden;
}
.carousel-control-prev, .carousel-control-next{
	top: 50%;
	transform: translateY(-50%);
	width: 40px;
	height: 40px;
	color: black;
	z-index: 10;
}

.carousel-control-prev {
	left: 0px;
}

.carousel-control-next {
	right: 0px;
}

.people-btn {
	width: 40px; /* 버튼 너비 고정 */
	font-size: 1.2rem; /* 폰트 크기 통일 */
	padding: 0; /* 기본 패딩 제거 */
	text-align: center; /* 가운데 정렬 */
}
/* 예약 섹션의 커스텀 반응형 컨테이너 */
.reserve-section {
	display: block;
}

/* 992px 이상이면 가로 배치 */
@media ( min-width : 992px) {
	.reserve-section {
		display: flex;
		gap: 2rem; /* 좌우 간격 */
	}
	.reserve-section>.left-image, .reserve-section>.right-info {
		flex: 1;
	}
}

</style>
</head>

<body>
<%@ include file="header.jsp"%>
<div class="container py-5 mt-5">

	<!-- 예약 정보 -->
	<div class="reserve-section mt-5 mb-4 px-5">
		<!-- 왼쪽 이미지 -->
		<div class="left-image mb-4 mb-md-0">
			<img src="./resources/img/kimbob.jpg" alt="예약 이미지" class="main-image img-fluid text-center">
		</div>

		<!-- 오른쪽 정보 -->
		<div class="right-info">
			<h3 class="pb-2"><b>김밥 만들기 체험</b></h3>
			<p><strong>체험일자 :</strong> 2025-06-07 12:00</p>
			<p><strong>마감일자 :</strong> 2025-05-10 (D-3)</p>
			<p><strong>현재정원 :</strong> 2명 / 10명</p>
			<p><strong>장소 :</strong> 서울시 구로구 더조은아카데미 2층</p>
			<p><strong>설명</strong></p>
			<p>이 예약 프로그램은 한국의 대중 음식 중 하나인 김밥을 만드는 프로그램입니다. 직접 재료를 손질하여 김밥을
				만들고 맛보는 체험을 경험하실 수 있습니다.</p>

			<!-- 예약하기 섹션 -->
			<div class="mb-3">
				<div class="p-4 border">
					<form action="#" method="post">
						<div class="g-3">
							<div class="col-md-12">
								<label for="name" class="form-label">예약자명</label>
								<input type="text" name="name" id="name" class="form-control mb-2"
									placeholder="이름을 입력하세요." required>
							</div>
							<div class="col-md-12">
								<label for="phone" class="form-label">연락처</label>
								<input type="text" class="form-control mb-2" id="phone" name="phone"
									placeholder="010-0000-0000" required>
							</div>
							<div class="col-md-12">
								<label for="people" class="form-label">인원수</label>
								<div class="input-group" style="max-width: 200px;">
									<button type="button" class="btn btn-outline-secondary people-btn"
										onclick="changePeople(-1)">−</button>
									<input type="number" id="people" name="people" class="form-control text-center" value="1" 
										min="1" max="10" readonly>
									<button type="button" class="btn btn-outline-secondary people-btn"
										onclick="changePeople(1)">＋</button>
								</div>
							</div>
						</div>
						<div class="text-end mt-4">
							<button type="button" class="btn btn-primary px-4 py-2"
								onclick="openConfirmModal()">예약하기</button>
						</div>
					</form>
					<!-- 예약 확인 모달 -->
					<div class="modal fade" id="confirmModal" tabindex="-1" aria-hidden="true">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<h5 class="modal-title">예약 정보 확인</h5>
									<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
								</div>
								<div class="modal-body">
									<p><strong>예약자명 : </strong> <span id="confirmName"></span></p>
									<p><strong>연락처 : </strong> <span id="confirmPhone"></span></p>
									<p><strong>인원수 : </strong> <span id="confirmPeople"></span></p>
									<p>해당 정보가 맞습니까?</p>
								</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
									<button type="button" class="btn btn-primary" onclick="submitForm()">확인</button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- 하단 슬라이드 이미지 (4장 수평 슬라이드) -->
	<h4 class="px-5">상세 이미지</h4>
	<div class="container-fluid px-0">
		<div id="detailCarousel" class="carousel slide mb-5 mt-2">
			<div class="carousel-inner">
			  	<div class="carousel-item active">
			    	<div class="d-flex justify-content-between custom-carousel-inner">
				      	<img src="./resources/img/kimbob1.jpg" class="d-block mx-1" alt="상세 이미지 1">
				      	<img src="./resources/img/kimbob2.jpg" class="d-block mx-1" alt="상세 이미지 2">
				      	<img src="./resources/img/kimbob3.jpg" class="d-block mx-1" alt="상세 이미지 3">
				      	<img src="./resources/img/kimbob4.jpg" class="d-block mx-1" alt="상세 이미지 4">
			    	</div>
			  	</div>
			  	<div class="carousel-item">
			    	<div class="d-flex justify-content-between custom-carousel-inner">
				      	<img src="./resources/img/back1.jpg" class="d-block mx-1" alt="상세 이미지 5">
				      	<img src="./resources/img/newyork.jpg" class="d-block mx-1" alt="상세 이미지 6">
				      	<img src="./resources/img/paris.jpg" class="d-block mx-1" alt="상세 이미지 7">
				      	<img src="./resources/img/img_avatar1.png" class="d-block mx-1" alt="상세 이미지 8">
			    	</div>
			  	</div>
			</div>
		
			<!-- 슬라이드 버튼 -->
			<button class="carousel-control-prev" type="button" data-bs-target="#detailCarousel" data-bs-slide="prev">
			  	<span class="fa-solid fa-chevron-left fa-2x text-dark"></span>
			</button>
			<button class="carousel-control-next" type="button" data-bs-target="#detailCarousel" data-bs-slide="next">
			  	<span class="fa-solid fa-chevron-right fa-2x text-dark"></span>
			</button>
		</div>
	</div>

	<!-- 후기 섹션 -->
	<h4 class="px-5 mt-5">후기</h4>
	<div id="reviewCarousel" class="carousel slide mb-5 px-5" data-bs-interval="false">
		<div class="carousel-inner">

			<!-- 슬라이드 1 -->
			<div class="carousel-item active">
				<div class="row gx-3">
					<div class="col-md-4">
						<div class="card h-100">
							<img src="./resources/img/newyork.jpg" class="card-img-top"
								alt="후기 이미지" style="height: 250px; object-fit: cover;">
							<div class="card-body text-center">
								<p class="card-text">정말 재밌는 시간이었어요!</p>
								<small class="text-muted">by 사용자A</small>
							</div>
						</div>
					</div>
					<div class="col-md-4">
						<div class="card h-100">
							<img src="./resources/img/paris.jpg" class="card-img-top"
								alt="후기 이미지" style="height: 250px; object-fit: cover;">
							<div class="card-body text-center">
								<p class="card-text">아이랑 같이 해서 좋았어요.</p>
								<small class="text-muted">by 사용자B</small>
							</div>
						</div>
					</div>
					<div class="col-md-4">
						<div class="card h-100">
							<img src="./resources/img/img_avatar1.png" class="card-img-top"
								alt="후기 이미지" style="height: 250px; object-fit: cover;">
							<div class="card-body text-center">
								<p class="card-text">또 참가하고 싶어요!</p>
								<small class="text-muted">by 사용자C</small>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- 슬라이드 2 -->
			<div class="carousel-item">
				<div class="row gx-3">
					<div class="col-md-4">
						<div class="card h-100">
							<img src="./resources/img/newyork.jpg" class="card-img-top"
								alt="후기 이미지" style="height: 250px; object-fit: cover;">
							<div class="card-body text-center">
								<p class="card-text">후기 4!</p>
								<small class="text-muted">by 사용자D</small>
							</div>
						</div>
					</div>
					<div class="col-md-4">
						<div class="card h-100">
							<img src="./resources/img/paris.jpg" class="card-img-top"
								alt="후기 이미지" style="height: 250px; object-fit: cover;">
							<div class="card-body text-center">
								<p class="card-text">후기 5.</p>
								<small class="text-muted">by 사용자E</small>
							</div>
						</div>
					</div>
					<div class="col-md-4">
						<div class="card h-100">
							<img src="./resources/img/img_avatar1.png" class="card-img-top"
								alt="후기 이미지" style="height: 250px; object-fit: cover;">
							<div class="card-body text-center">
								<p class="card-text">후기 6!</p>
								<small class="text-muted">by 사용자F</small>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- 슬라이드 버튼 -->
		<button class="carousel-control-prev" type="button" data-bs-target="#reviewCarousel" data-bs-slide="prev">
			<span class="fa-solid fa-chevron-left fa-2x text-dark"></span>
		</button>
		<button class="carousel-control-next" type="button" data-bs-target="#reviewCarousel" data-bs-slide="next">
			<span class="fa-solid fa-chevron-right fa-2x text-dark"></span>
		</button>
	</div>
</div>
<%@ include file="footer.jsp"%>
</body>
<script>
	function openConfirmModal() {
		const name = document.getElementById("name").value;
		const phone = document.getElementById("phone").value;
		const people = document.getElementById("people").value;

		if (!name || !phone || !people) {
			alert("모든 항목을 입력해주세요.");
			return;
		}

		document.getElementById("confirmName").innerText = name;
		document.getElementById("confirmPhone").innerText = phone;
		document.getElementById("confirmPeople").innerText = people;

		const modal = new bootstrap.Modal(document
				.getElementById('confirmModal'));
		modal.show();
	}

	function submitForm() {
		document.querySelector("form").submit();
	}
	function changePeople(delta) {
		const input = document.getElementById('people');
		let value = parseInt(input.value) || 1;
		const min = parseInt(input.min);
		const max = parseInt(input.max);

		value += delta;

		if (value < min)
			value = min;
		if (value > max)
			value = max;

		input.value = value;
	}
</script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</html>
