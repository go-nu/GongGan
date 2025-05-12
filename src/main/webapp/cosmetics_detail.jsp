<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import = "java.util.*" %>
<%@ page import="dao.CosmeticsRepository" %>
<%@ page import="dto.Cosmetics" %>
<html>
<head>
<title>화장품 상세 페이지</title>
<link rel="stylesheet" href="./resources/css/index_style.css">
<link rel="stylesheet" href="./resources/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<script src="./resources/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="./resources/css/rsv_style.css">
</head>
<style>
	.right-info p{
		font-size: 18px;
	}
</style>
<body>
<%@ include file="header.jsp"%>
<%@ include file="dbconn.jsp" %>

<div class="container py-5 mt-5">
	<!-- 화장품 정보 -->
	<div class="reserve-section mt-5 mb-4 px-5">
		<%
			String id_string = request.getParameter("id");
			int id = (id_string == null || id_string.isEmpty()) ? 0 : Integer.parseInt(id_string);

			CosmeticsRepository repo = CosmeticsRepository.getInstance();
			Cosmetics c = repo.getCosmeticsById(id);

			if (c != null) {
		%>
		<!-- 왼쪽 이미지 -->
		<div class="left-image mb-4 mb-md-0">
			<img src="./resources/img/<%= c.getImage_file() %>" alt="화장품 이미지" class="main-image img-fluid text-center">
		</div>

		<!-- 오른쪽 정보 -->
		<div class="right-info">
			<h3 class="pb-3"><b><%= c.getName() %></b></h3>
			<p><strong>브랜드 :</strong> <%= c.getBrand() %></p>
			<p><strong>가격 :</strong> <%= c.getPrice() %>원</p>
			<p><strong>메인성분 :</strong> <%= c.getMain_ingredient() %></p>
			<p><strong>효과/효능 :</strong> <%= c.getEffect() %></p>
			<p><strong>카테고리 :</strong> <%= c.getCategory() %></p>
			<p><strong>좋아요 수 :</strong> <%= c.getLikes() %></p>
		<%
			}
		%>
		</div>
	</div>
</div>

<!-- 관련 상품(같은 카테고리) -->
<section class="about-section" style="padding: 60px 0;">
	<div class="container">
		<h3 class="px-5 pb-3">관련 상품</h3>
		<div id="reviewCarousel" class="carousel slide mb-5 px-5" data-bs-interval="false">
			<div class="carousel-inner">
				<%
					List<Cosmetics> relatedList = repo.getRelatedCosmetics(c.getCategory(), c.getId(), 12);
					int groupSize = 4;
					int total = relatedList.size();
					int slideCount = (int) Math.ceil(total / (double) groupSize);
	
					for (int slide = 0; slide < slideCount; slide++) {
				%>
				<div class="carousel-item <%= (slide == 0) ? "active" : "" %>">
					<div class="row">
						<%
							for (int i = slide * groupSize; i < Math.min((slide + 1) * groupSize, total); i++) {
								Cosmetics r = relatedList.get(i);
						%>
						<div class="col-md-3 text-center">
							<div class="card border-0">
								<img src="./resources/img/<%= r.getImage_file() %>" class="card-img-top img-fluid" alt="<%= r.getName() %>" style="height: 200px; object-fit: cover;">
								<div class="card-body">
									<h6 class="card-title"><%= r.getName() %></h6>
									<a href="cosmetics_detail.jsp?id=<%= r.getId() %>" class="btn btn-sm btn-outline-primary">상세보기</a>
								</div>
							</div>
						</div>
						<%
							}
						%>
					</div>
				</div>
				<%
					}
				%>
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
</section>

<!-- 공란 -->
<section class="class-section" style="min-height: 160px;">
	<div class="container">
		<!-- 공란 -->
  	</div>
</section>	

<%@ include file="footer.jsp"%>

</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</html>
