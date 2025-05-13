<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="./resources/css/header.css">
</head>
    <header>
        <div class="container">
            <div class="header-content">
                <a class="logo" href="index.jsp">K-<span>CULTURE</span> GUIDE</a>
                <nav>
                    <ul>
                    	<!-- 관리자권한일 때 헤더 메뉴 -->
                    	<% if (request.isUserInRole("admin")) { %>
                    	<li><a href="food.jsp">한식 (K-FOOD)</a></li>
                    	<li><a href="Admin_Cosmetics.jsp">뷰티 (K-BEAUTY)</a></li>
                    	<li><a href="location.jsp">관광지 (LOCATION)</a></li>
                    	<li><a href="logout.jsp">로그아웃</a></li>
                        <li><a href="#">관리자페이지</a></li>
                        
                    	<!-- 일반 유저(로그인)일 때 헤더 메뉴 -->
                    	<%} else if (session.getAttribute("id") != null) { %>
                    	<li><a href="food.jsp">한식 (K-FOOD)</a></li>
                    	<li><a href="beauty.jsp">뷰티 (K-BEAUTY)</a></li>
                    	<li><a href="location.jsp">관광지 (LOCATION)</a></li>
                    	<li><a href="logout.jsp">로그아웃</a></li>
                        <li><a href="MyPage.do">마이페이지</a></li>
                        
                    	<!-- 일반 유저(비로그인)일 때 헤더 메뉴 -->
                    	<%} else {%>
                    	<li><a href="food.jsp">한식 (K-FOOD)</a></li>
                    	<li><a href="beauty.jsp">뷰티 (K-BEAUTY)</a></li>
                    	<li><a href="location.jsp">관광지 (LOCATION)</a></li>
                    	<li><a href="login.jsp">로그인</a></li>
                        <li><a href="signin.jsp">회원가입</a></li>
                    	<% } %>
                </nav>
            </div>
        </div>
    </header>
