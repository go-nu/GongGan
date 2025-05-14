<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="./resources/css/header.css">
</head>
<%
	String redirectURL = request.getRequestURI();
	String queryString = request.getQueryString();
	if (queryString != null) {
	    redirectURL += "?" + queryString;
	}
	// JSP 파일일 경우 → 해당 JSP로 forward하는 .do 주소로 교체
	if (redirectURL.contains("board/list.jsp")) {
	    redirectURL = "/K_Culture/BoardListAction.do" + (queryString != null ? "?" + queryString : "");
	} else if (redirectURL.contains("board/view.jsp")) {
	    redirectURL = "/K_Culture/BoardViewAction.do" + (queryString != null ? "?" + queryString : "");
	}
	String encodedRedirect = java.net.URLEncoder.encode(redirectURL, "UTF-8");
%>
    <header>
        <div class="container">
            <div class="header-content">
                <a class="logo" href="index.jsp">K-<span>CULTURE</span> GUIDE</a>
                <nav>
                    <ul>
                    	<!-- 관리자권한일 때 헤더 메뉴 -->
                    	<% if (request.isUserInRole("admin")) { %>
                    	<li><a href="food.jsp">한식 (K-FOOD)</a></li>
                    	<li><a href="cosmetics?action=adminlist">뷰티 (K-BEAUTY)</a></li>
                    	<li><a href="location.jsp">관광지 (LOCATION)</a></li>
                    	<li><a href="logout.jsp">로그아웃</a></li>
                        <li><a href="#">관리자페이지</a></li>
                        
                    	<!-- 일반 유저(로그인)일 때 헤더 메뉴 -->
                    	<%} else if (session.getAttribute("id") != null) { %>
                    	<li><a href="food.jsp">한식 (K-FOOD)</a></li>
                    	<li><a href="cosmetics?action=list">뷰티 (K-BEAUTY)</a></li>
                    	<li><a href="location.jsp">관광지 (LOCATION)</a></li>
                    	<li><a href="logout.jsp">로그아웃</a></li>
                        <li><a href="MyPage.do">마이페이지</a></li>
                        
                    	<!-- 일반 유저(비로그인)일 때 헤더 메뉴 -->
                    	<%} else {%>
                    	<li><a href="food.jsp">한식 (K-FOOD)</a></li>
                    	<li><a href="cosmetics?action=list">뷰티 (K-BEAUTY)</a></li>
                    	<li><a href="location.jsp">관광지 (LOCATION)</a></li>
                   		<li><a href="login.jsp?redirect=<%= encodedRedirect %>">로그인</a></li>	<!-- 로그인 후 이전 페이지로 이동 -->
                        <li><a href="signin.jsp">회원가입</a></li>
                    	<% } %>
                </nav>
            </div>
        </div>
    </header>
