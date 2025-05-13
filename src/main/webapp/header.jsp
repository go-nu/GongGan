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
                        <li><a href="food.jsp">한식 (K-FOOD)</a></li>
                        <li><a href="beauty.jsp">뷰티 (K-BEAUTY)</a></li>
                        <li><a href="location.jsp">관광지 (LOCATION)</a></li>
                        <!-- 로그인세션 이름: sessionId -->
                        <% if (session.getAttribute("id") != null) { %>
                            <li><a href="logout.jsp">로그아웃</a></li>
                            <li><a href="MyPage.do">마이페이지</a></li>
                        <% } else { %>
                            <li><a href="login.jsp">로그인</a></li>
                            <li><a href="signin.jsp">회원가입</a></li>
                        <% } %>
                    </ul>
                </nav>
            </div>
        </div>
    </header>
