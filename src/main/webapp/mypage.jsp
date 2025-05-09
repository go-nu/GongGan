<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>[사이트 이름]</title>
	<script src="./resources/js/bootstrap.bundle.min.js"></script>
	<link href="./resources/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="./resources/css/index_style.css">
</head>
<body>
    <%@ include file="header.jsp" %>
    
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
                <h2>내가 쓴 글</h2>
            </div>
            
        </div>
    </section>
    
<!-- 초록칸 -->
    <section class="about-section">
        <div class="container">
			<div class="section-title">
				<h2>내가 쓴 댓글</h2>
			</div>
        </div>
    </section>
    
<!-- 사이트 설명 -->
    <section class="community-section">
        <div class="container">
            <div class="section-title">
                <h2>내가 신청한 프로그램</h2>
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