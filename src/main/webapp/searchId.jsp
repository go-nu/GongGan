<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>
<script src="./resources/js/bootstrap.bundle.min.js"></script>
<link href="./resources/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="./resources/css/index_style.css">
<link rel="stylesheet" href="./resources/css/login.css">
</head>
<body>
<%@ include file="header.jsp" %>
<section class="hero">
	<div class="container">
		<div class="row align-items-md-stretch   text-center">
			<div class="row justify-content-center align-items-center">
				<div class="h-100 p-5 col-md-6">
					<h2 class="my-5">아이디 찾기</h2>
					<!-- 이름과 전화번호로 아이디 찾기 -->
			        <form class="form-signin" action="processSearchId.jsp" method="post">
   			 		<!-- 이름과 전화번호가 일치하면 아이디를 알려주는 processSearchId.jsp -->
			            <div class="mb-4">
		                    <!-- 이름 입력란 -->
		                    <div class="form-floating">
		                        <input type="text" class="form-control" id="name" name="name" required autofocus>
		                        <label for="name">이름</label>
		                    </div>
			            </div>
			            <div class="mb-4">
			                <div class="form-floating">
			                    <!-- 전화번호 입력란 -->
			                    <input type="text" class="form-control" id="phone" name="phone" required>
			                    <label for="phone">전화번호</label>
			                </div>
			            </div>
			            <button type="submit" class="btn btn-lg btn-success w-100">아이디 찾기</button>
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