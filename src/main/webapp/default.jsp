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
    <title>[사이트 이름]</title>
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
<!-- 슬라이드 -->
	<section class="hero">
		<div id="colorCarousel" class="carousel slide" data-bs-ride="carousel">
			<div class="carousel-inner">
		    	<div class="carousel-item active">
					<img src="./resources/img/slideimg01.jpg" class="d-block w-100" alt="...">
					<div class="fixed-caption">
					  	<h3>h3</h3>
					  	<p>p</p>
					</div>
		    	</div>
		  	</div>
	  	</div>
    </section>
    
<!-- 메인 카테고리 -->
    <section class="featured-section">
        <div class="container">
            <div class="section-title">
                <h2>제목</h2>
            </div>
            
        </div>
    </section>
    
<!-- 초록칸 -->
    <section class="about-section">
        <div class="container">

        </div>
    </section>
    
<!-- 사이트 설명 -->
    <section class="community-section">
        <div class="container">

        </div>
    </section>
    
    
    <%@ include file="footer.jsp" %>
</body>
</html>