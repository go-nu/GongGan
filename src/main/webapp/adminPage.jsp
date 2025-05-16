<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*"%>
<%@ page import="mvc.model.BoardDTO"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>My Page</title>
	<script src="./resources/js/bootstrap.bundle.min.js"></script>
	<link href="./resources/css/bootstrap.min.css" rel="stylesheet">
	<link rel="stylesheet" href="./resources/css/mp_style.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />
</head>
<body>
	<%@ include file="header.jsp"%>

	<!-- 슬라이드 -->
	<section class="hero">
		<div id="colorCarousel" class="carousel slide" data-bs-ride="carousel">
			<div class="carousel-inner">
				<div class="carousel-item active">
					<img src="./resources/img/slideimg01.jpg" class="d-block w-100" alt="...">
					<div class="fixed-caption">
						<h3>myPage</h3>
						
					</div>
				</div>
			</div>
		</div>
	</section>

	<div class="container mt-5">
		<div class="justify-content-center">
			<div class="section-title">
				<h2>공지글 작성</h2>
				<p><%=session.getAttribute("id") %></p>
			</div>
			<section class="board-section">
				<div class="container">


				</div>
			</section>
		</div>
	</div>

<!-- 체험 활동 -->
	<%@ include file="totalReservationList.jsp" %>	

	<section class="community-section">
		<div class="container">
		</div>
	</section>

    <%@ include file="swiper.jsp" %>
	<%@ include file="footer.jsp"%>
</body>
</html>
