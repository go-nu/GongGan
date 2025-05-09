<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isErrorPage="true"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>[사이트 이름]</title>
	<script src="./resources/js/bootstrap.bundle.min.js"></script>
	<link href="./resources/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="./resources/css/index_style.css">
    <style>
    	.empty {
    		height: 250px;
    	}
    	.empty-t {
    		height: 300px;
    	}
    	.about-section {
    		height: 300px;
    	}
    </style>
</head>
<body>
    <%@ include file="header.jsp" %>
    <section class="empty empty-t"></section>
    <!-- 초록칸 -->
    <section class="about-section">
        <div class="container">
            <div class="about-content">
                <div class="about-text">
                    <h2 class="my-3">요청하신 페이지를 찾을 수 없습니다.</h2>
                    <p class="mt-5"><%=request.getRequestURL()%></p>
                    <a href="javascript:history.back()">← 뒤로가기</a>
                </div>
            </div>
        </div>
    </section>
    <section class="empty"></section>
	<footer>
        <div class="container">
            <div class="copyright">
                <p>&copy; 2025 K-CULTURE GUIDE. All rights reserved.</p>
            </div>
        </div>
    </footer>
</body>
</html>