<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*"%>
<%@ page import="mvc.model.BoardDTO"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.ParseException" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GONGGAN 소개</title>
	<script src="./resources/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="./resources/css/ap_style.css">
	<link href="./resources/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <%@ include file="header.jsp" %>
    
<!-- 메인 카테고리 -->
    <section class="featured-section">
		 <div class="container pt-5">
	        <div class="row align-items-center g-1">
	        	<div class="col-md-1"></div>
	            <!-- 이미지 영역 -->
	            <div class="col-md-5 text-end">
	                <img src="./resources/img/intro.png" class="img-fluid" style="height:560px; width:420px;">
	            </div>
	
	            <!-- 텍스트 영역 -->
	            <div class="col-md-5 ms-5">
	            	<h2 class="mb-2">공간 소개</h2>
	                <p>GONG GAN은 K-POP, K-FOOD, K-BEAUTY 등 전 세계적으로 사랑받는 한국 문화에
	                    관심이 있는 외국인 관광객들을 위한 정보 공유 커뮤니티 플랫폼입니다.</p>
	
	                <p>한국을 찾은 관광객들이 K-컬쳐 관련 정보를 얻기 위해 여러 사이트를 돌아다니며 흩어진 정보들을 찾아야 하는
	                    불편함을 해소하고자, GONG GAN에서는 다양한 한국 문화 콘텐츠를 모아 통합적으로 제공합니다.</p>
	
	                <p>이 플랫폼에서는 맛집 추천, 뷰티 제품 정보, K-POP 관련 장소 소개 등 실제 방문자들의 생생한 경험을
	                    게시판을 통해 서로 공유하고, 댓글을 통해 자유롭게 소통할 수 있습니다.</p>
	
	                <p>또한 단순히 문화 콘텐츠를 즐기는 것뿐만 아니라, 지역별 관광지 정보도 함께 제공하여 
	                    한국의 다양한 지역과 문화에 쉽게 다가가고 체험할 수 있도록 구성되어 있습니다.</p>
	
	                <p>GONG GAN은 여기에 더해, 외국인 관광객들이 직접 참여할 수 있는 
	                    원데이 클래스 신청 기능도 제공합니다. 
	                    전통 음식 만들기, K-뷰티 체험, K-POP 댄스 클래스 등 
	                    다양한 체험 활동을 플랫폼 내에서 간편하게 예약하고 참여할 수 있어, 
	                    단순한 여행을 넘어 <strong>직접 경험하고 소통하는 진짜 한국 문화</strong>를 느낄 수 있습니다.</p>
	            </div>
	        </div>
	    </div>
    </section>
    
<!-- 체험 활동 -->
	<section class="about-section" style="padding: 80px 0;">
    <div class="container">
    
        <!-- 커뮤니티 카드 목록 -->
        <div class="community-cards d-flex justify-content-center flex-wrap gap-4">
            <!-- 카드 1 -->
            <div class="community-card text-center p-4 border rounded shadow-sm" style="width: 300px;">
                <div class="community-icon mb-3" style="font-size: 40px;">🍱‍</div>
                <h3 style="font-size: 20px;">FOOD</h3>
                <p class="mt-2" style="font-size: 15px;">
                    원데이 클래스
                </p>
            </div>

            <!-- 카드 2 -->
            <div class="community-card text-center p-4 border rounded shadow-sm" style="width: 300px;">
                <div class="community-icon mb-3" style="font-size: 40px;">💄</div>
                <h3 style="font-size: 20px;">BEAUTY</h3>
                <p class="mt-2" style="font-size: 15px;">
                    화장품 정보 공유
                </p>
            </div>

            <!-- 카드 3 -->
            <div class="community-card text-center p-4 border rounded shadow-sm" style="width: 300px;">
                <div class="community-icon mb-3" style="font-size: 40px;">🗺</div>
                <h3 style="font-size: 20px;">LOCATION</h3>
                <p class="mt-2" style="font-size: 15px;">
                    관광 정보 공유
                </p>
            </div>
        	</div>
    	</div>
	</section>

<!-- 공란 -->
    <section class="community-section">
		
	</section>	
	
    <%@ include file="swiper.jsp" %>
    <%@ include file="footer.jsp" %>
</body>
</html>