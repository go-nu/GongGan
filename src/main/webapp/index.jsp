<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
    String id = (String) session.getAttribute("id");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GONGGAN</title>
	<script src="./resources/js/bootstrap.bundle.min.js"></script>
	<link href="./resources/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="./resources/css/index_style.css">
<style>
	.floating-edit-btn {
		position: fixed;
		bottom: 30px;
		right: 30px;
		z-index: 999;
		background-color: #007bff;
		color: white;
		padding: 12px 18px;
		border-radius: 30px;
		text-decoration: none;
		font-weight: bold;
		box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
		transition: background-color 0.3s;
	}
	
	.floating-edit-btn:hover {
		background-color: #0056b3;
	}
</style>
</head>
<body>
    <%@ include file="header.jsp" %>
    <%
	if (request.isUserInRole("admin")) {
	%>
	    <a href="editPage.jsp?page=index.jsp" class="floating-edit-btn">현재 페이지 수정</a>
	<%
	}
	%>
<!-- 슬라이드 -->
	<section class="hero">
		<div id="colorCarousel" class="carousel slide" data-bs-ride="carousel">
			<div class="carousel-inner">
		    	<div class="carousel-item active">
					<img src="./resources/img/slideimg01.jpg" class="d-block w-100" alt="...">
					<div class="fixed-caption">
					  	<h3>K-FOOD</h3>
					  	<p>K-FOOD 한식 | 김치, 불고기, 비빔밥, 조미김, 불닭볶음면, 떡볶이</p>
					</div>
		    	</div>
		    	<div class="carousel-item">
					<img src="./resources//img/slideimg02.jpg" class="d-block w-100" alt="...">
					<div class="fixed-caption">
					  	<h3>K-BEAUTY 한국의 뷰티 상품</h3>
					  	<p>Explore the rich and vibrant world of Korean culture!</p>
					</div>
		   		</div>
		    	<div class="carousel-item">
					<img src="./resources//img/slideimg04.jpg" class="d-block w-100" alt="...">
					<div class="fixed-caption">
					  	<h3>LOCATION</h3>
					  	<p>한국의 전통 관광지와 내 스타가 다녀간 장소들</p>
					</div>
		    	</div>
		  	</div>
		  	<button class="carousel-control-prev" type="button" data-bs-target="#colorCarousel" data-bs-slide="prev">
		    	<span class="carousel-control-prev-icon" aria-hidden="true"></span>
		  	</button>
		  	<button class="carousel-control-next" type="button" data-bs-target="#colorCarousel" data-bs-slide="next">
			    <span class="carousel-control-next-icon" aria-hidden="true"></span>
		  	</button>
	  	</div>
    </section>
    
<!-- 메인 카테고리 -->
    <section class="featured-section">
        <div class="container">
            <div class="section-title">
                <h2>메인 카테고리</h2>
            </div>
            <div class="category-grid">
                <%-- 여기에 서버 측 데이터로 반복 출력 가능 --%>
                <div class="category-card" onclick="location.href='food.jsp'" style="cursor: pointer;">
                    <img src="./resources/img/category_f.JPG" class="category-image">
                    <div class="category-info">
                        <h3>K-FOOD</h3>
                        <p>한국 음식(한식)에 대한 정보 나눔</p>
                        <div>
                            <span class="tag">한식 레시피 나눔</span>
                            <span class="tag">맛집 공유</span>
                            <span class="tag">원데이 클래스 예약</span>
                        </div>
                    </div>
                </div>
                <div class="category-card" onclick="location.href='${pageContext.request.contextPath}/cosmetics?action=list'" style="cursor: pointer;">
                	<img src="./resources/img/category_b.jpg" class="category-image">
                    <div class="category-info">
                        <h3>K-BEAUTY</h3>
                        <p>한국의 화장품에 대한 정보 나눔</p>
                        <div>
                            <span class="tag">화장품 정보 공유</span>
                        </div>
                    </div>
                </div>
                <div class="category-card" onclick="location.href='location.jsp'" style="cursor: pointer;">
                    <img src="./resources/img/category_l.jpg" class="category-image">
                    <div class="category-info">
                        <h3>LOCATION</h3>
                        <p>한국 관광지에 대한 정보 나눔</p>
                        <div>
                            <span class="tag">내 스타가 다녀간 곳</span>
                            <span class="tag">전통 관광지</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    
<!-- 초록칸 -->
    <section class="about-section">
        <div class="container">
            <div class="about-content">
                <div class="about-text">
                    <h2>한국을 방문한 <br>외국인 관광객수</h2>
                    <p>여성 관광객이 남성보다 월등히 많음</p>
                </div>
                <div class="about-image">
					<%@ include file="chart.jsp" %>
                </div>
            </div>
        </div>
    </section>
    
<!-- 사이트 설명 -->
    <section class="community-section">
        <div class="container">
            <div class="section-title">
                <h2>[사이트 이름] 사용법</h2>
                <p>사용법 어쩌고 저쩌고</p>
            </div>
            <div class="community-cards">
                <div class="community-card">
                    <div class="community-icon">👨‍👩‍👧‍👦</div>
                    <h3>정보 공유</h3>
                    <p>나만의 특별한 경험과 유익한 정보를 <br>다른 이들과 나눠보아요</p>
                </div>
                <div class="community-card">
                    <div class="community-icon">🗺</div>
                    <h3>장소 찾기</h3>
                    <p>지도를 보며 체험 장소를 찾아보거나 <br>주변 맛집을 찾아보아요</p>
                </div>
                <div class="community-card">
                    <div class="community-icon">✍</div>
                    <h3>체험 클래스</h3>
                    <p>다양한 원데이 클래스들을 골라 <br>체험해 보아요</p>
                </div>
            </div>
        </div>
    </section>
    
    
    <%@ include file="footer.jsp" %>
</body>
</html>