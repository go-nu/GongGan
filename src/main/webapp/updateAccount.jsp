<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>내 정보 수정</title>
<script src="./resources/js/bootstrap.bundle.min.js"></script>
<link href="./resources/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="./resources/css/index_style.css">
</head>
<body>
	<%
	String id = (String) session.getAttribute("id");
	String name = (String) session.getAttribute("name");
	String gender = (String) session.getAttribute("gender");
	String birth = (String) session.getAttribute("birth");
	String email = (String) session.getAttribute("email");
	String phone = (String) session.getAttribute("phone");
	String address = (String) session.getAttribute("address");
	%>
	<%@ include file="header.jsp"%>

	<!-- 슬라이드 -->
	<section class="hero">
		<div id="colorCarousel" class="carousel slide" data-bs-ride="carousel">
			<div class="carousel-inner">
				<div class="carousel-item active">
					<img src="./resources/img/slideimg01.jpg" class="d-block w-100"
						alt="...">
					<div class="fixed-caption">
						<h3>K-FOOD</h3>
						<p>K-FOOD 한식 | 김치, 불고기, 비빔밥, 조미김, 불닭볶음면, 떡볶이</p>
					</div>
				</div>
				<div class="carousel-item">
					<img src="./resources//img/slideimg02.jpg" class="d-block w-100"
						alt="...">
					<div class="fixed-caption">
						<h3>K-BEAUTY 한국의 뷰티 상품</h3>
						<p>Explore the rich and vibrant world of Korean culture!</p>
					</div>
				</div>
				<div class="carousel-item">
					<img src="./resources//img/slideimg04.jpg" class="d-block w-100"
						alt="...">
					<div class="fixed-caption">
						<h3>LOCATION</h3>
						<p>한국의 전통 관광지와 내 스타가 다녀간 장소들</p>
					</div>
				</div>
			</div>
			<button class="carousel-control-prev" type="button"
				data-bs-target="#colorCarousel" data-bs-slide="prev">
				<span class="carousel-control-prev-icon" aria-hidden="true"></span>
			</button>
			<button class="carousel-control-next" type="button"
				data-bs-target="#colorCarousel" data-bs-slide="next">
				<span class="carousel-control-next-icon" aria-hidden="true"></span>
			</button>
		</div>
	</section>

	<!-- 내 정보 아이디, 이름, 성별, 생일, 이메일, 전화번호, 주소 -->
	<div class="container">
		<div class="row justify-content-center">
			<div class="col-md-6">
			<div class="section-title">
				<h2>내 정보</h2>
			</div>
				<!-- 또는 col-lg-5, col-sm-8 등으로 조절 -->
				<form>
					<form action="updateInfo.do" method="post">
						<div class="mb-3">
							<label class="form-label">아이디</label> <input type="text"
								name="id" class="form-control" value="<%=id%>" readonly>
						</div>

						<div class="mb-3">
							<label class="form-label">이름</label> <input type="text"
								name="name" class="form-control" value="<%=name%>">
						</div>

						<div class="mb-3">
							<label class="form-label">성별</label><br>
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="radio" name="gender"
									value="남" <%="남".equals(gender) ? "checked" : ""%>> <label
									class="form-check-label">남</label>
							</div>
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="radio" name="gender"
									value="여" <%="여".equals(gender) ? "checked" : ""%>> <label
									class="form-check-label">여</label>
							</div>
						</div>

						<div class="mb-3">
							<label class="form-label">생일</label> <input type="date"
								name="birth" class="form-control" value="<%=birth%>">
						</div>

						<div class="mb-3">
							<label class="form-label">이메일</label> <input type="email"
								name="email" class="form-control" value="<%=email%>">
						</div>

						<div class="mb-3">
							<label class="form-label">전화번호</label> <input type="tel"
								name="phone" class="form-control" value="<%=phone%>">
						</div>

						<div class="mb-3">
							<label class="form-label">주소</label> <input type="text"
								name="address" class="form-control" value="<%=address%>">
						</div>

						<button type="submit" class="btn btn-primary">정보 수정</button>
					</form>
				</form>
			</div>
		</div>
	</div>

	<%@ include file="footer.jsp"%>
</body>
</html>