<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<script src="./resources/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="./resources/css/index_style.css">
<link href="./resources/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="./resources/css/login.css">
<link rel="stylesheet" href="./resources/css/footer.css">
<style>
.copyright>p {
	display: inline-block;
}

.copyright>a {
	color: #1d3557;
}
.btn:hover {
	background-color: #1d2757 !important;
}
</style>
</head>
<body>
	<%@ include file="header.jsp"%>

	<section class="hero" style="padding-top: 100px; margin-bottom: 100px;">
		<div class="container">
			<div class="row align-items-md-stretch   text-center">
				<div class="row justify-content-center align-items-center">
					<div class="h-100 p-5 col-md-6">
						<h2 class="my-5">관리자 로그인</h2>

						<form class="form-signin" action="j_security_check" method="post">
							<div class="mb-4">
								<!-- 아이디 입력란 -->
								<div class="form-floating">
									<input type="text" class="form-control" id="id"
										name="j_username" required autofocus> <label for="id">ID</label>
								</div>
							</div>
							<div class="mb-4">
								<div class="form-floating">
									<!-- 비밀번호 입력란 -->
									<input type="password" class="form-control" id="password"
										name="j_password" required> <label for="password">Password</label>
								</div>
							</div>
							<button type="submit" class="btn btn-lg w-100">로그인</button>
						</form>
						<!-- 아이디/비밀번호 찾기, 회원가입 링크 추가 -->
						<div class="d-flex justify-content-center mt-3" >
							<a href="#" class="text-decoration-none mx-2" style="color:#fafafa; cursor:default;">a</a>
							<a href="#" class="text-decoration-none mx-2" style="color:#fafafa; cursor:default;">a</a>
							<a href="#" class="text-decoration-none mx-2" style="color:#fafafa; cursor:default;">a</a>
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