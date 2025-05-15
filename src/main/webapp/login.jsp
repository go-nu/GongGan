<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<script src="./resources/js/bootstrap.bundle.min.js"></script>
<link href="./resources/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="./resources/css/index_style.css">
<link rel="stylesheet" href="./resources/css/login.css">
</head>
<body>
<%@ include file="header.jsp" %>

<!-- 로그인 후 이전 페이지로 이동 -->
<%
    String redirect = request.getParameter("redirect");
    if (redirect != null && !redirect.contains("login.jsp")) {
        session.setAttribute("redirectAfterLogin", redirect);
    }
%>
<section class="hero">
	<div class="container">
		<div class="row align-items-md-stretch   text-center">
			<div class="row justify-content-center align-items-center">
				<div class="h-100 p-5 col-md-6">
					<h2 class="my-5">로그인</h2>
					
			        <form class="form-signin" action="processLogin.jsp" method="post">
			            <div class="mb-4">
		                    <!-- 아이디 입력란 -->
		                    <div class="form-floating">
		                        <input type="text" class="form-control" id="id" name="id" required autofocus>
		                        <label for="id">ID</label>
		                    </div>
			            </div>
			            <div class="mb-4">
			                <div class="form-floating">
			                    <!-- 비밀번호 입력란 -->
			                    <input type="password" class="form-control" id="password" name="password" required>
			                    <label for="password">Password</label>
			                </div>
			            </div>
			            <button type="submit" class="btn btn-lg w-100">로그인</button>
			        </form>
			        <!-- 아이디/비밀번호 찾기, 회원가입 링크 추가 -->
	                <div class="d-flex justify-content-center mt-3">
	                    <a href='<c:url value="searchId.jsp"/>' class="text-decoration-none mx-2">아이디 찾기</a>   
	                    <a href='<c:url value="searchPassword.jsp"/>' class="text-decoration-none mx-2">비밀번호 찾기</a>   
	                    <a href='<c:url value="signin.jsp"/>' class="text-decoration-none mx-2">회원가입</a>
	                </div>
        		</div>
        	</div>
        </div>
    </div>
</section>
	<footer>
        <div class="container">
            <div class="copyright">
                <p>&copy; 2025 K-CULTURE GUIDE. All rights reserved.</p>
            </div>
        </div>
    </footer>
</body>
</html>