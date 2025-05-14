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
    
    <!-- header.jsp 또는 menu.jsp 하단부 -->
<button id="topBtn" onclick="scrollToTop()">▲ TOP</button>

<script>
window.onscroll = function () {
  const topBtn = document.getElementById("topBtn");
  if (document.body.scrollTop > 200 || document.documentElement.scrollTop > 200) {
    topBtn.style.display = "block";
  }
};

function scrollToTop() {
  window.scrollTo({ top: 0, behavior: 'smooth' });
}
</script>

<style>
#topBtn {
  position: fixed;
  bottom: 80px;
  right: 40px;
  z-index: 999;
  border: none;
  outline: none;
  background-color: white;
  color: black;
  cursor: pointer;
  padding: 16px 12px;
  border-radius: 50%;
  font-size: 16px;
  box-shadow: 0 2px 6px rgba(0, 0, 0, 0.2);
  opacity: 0.7;  /* 🔹 처음엔 옅게 */
  transition: all 0.3s ease;  /* 🔹 전체 부드러운 변화 */
}

#topBtn:hover {
  opacity: 1;  /* 🔹 진하게 */
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.4);
}

</style>
    
