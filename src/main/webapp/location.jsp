<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>[사이트 이름]</title>
	<script src="./resources/js/bootstrap.bundle.min.js"></script>
	<link href="./resources/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="./resources/css/location_style.css">
</head>
<body>
    <%@ include file="header.jsp" %>
    
<!-- 슬라이드 -->
    <section class="hero">
		<div id="colorCarousel" class="carousel slide" data-bs-ride="carousel">
			<div class="carousel-inner">
		    	<div class="carousel-item active">
					<img src="./resources//img/slideimg04.jpg" class="d-block w-100" alt="...">
					<div class="fixed-caption">
					  	<h3>TOURIST ATTRACTION</h3>
					  	<p>한국의 전통 관광지와 내 스타가 다녀간 장소들</p>
					</div>
		   		</div>
		  	</div>
	  	</div>
    </section>
    
<!-- 메인 카테고리 -->
    <section class="featured-section">
        <div class="container">
            <div class="section-title">
                <h2>이번주 생일 카페</h2>
            </div>
            <%@ include file="map2.jsp" %>
        </div>
    </section>
    
<!-- 초록칸 -->
    <section class="about-section">
        <div class="container">
            <div class="about-content">
                <div class="about-text">
                    <h2>K-CULTURE</h2>
                    <p>K-CULTURE 한류 문화에 대한 정보 글 간단히 + 그래프? 같은거 넣으면 좋을듯</p>
                    <p>ㄹㅇㄹㅇ</p>
                    <p>ㅇㅈㅇㅈ</p>
                </div>
                <div class="about-image"></div>
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