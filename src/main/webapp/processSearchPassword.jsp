<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ include file="dbconn.jsp" %>
<%
	request.setCharacterEncoding("UTF-8");
	String id = request.getParameter("id");
	String phone = request.getParameter("phone");
	request.setAttribute("id", id);
%>
<sql:query dataSource="${dataSource}" var="result">
	select * from users where id = ? and phone = ?
	<sql:param value="${param.id}" />
	<sql:param value="${param.phone}" />
</sql:query>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="./resources/js/bootstrap.bundle.min.js"></script>
<link href="./resources/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="./resources/css/index_style.css">
<link rel="stylesheet" href="./resources/css/login.css">
</head>
<body>
	<%@ include file="header.jsp"%>
	<section class="hero">
		<div class="container">
			<div class="row align-items-md-stretch   text-center">
				<div class="row justify-content-center align-items-center">
					<div class="h-100 p-5 col-md-6">
						<c:choose>
							<c:when test="${not empty result.rows}">
								<h2 class="my-5">비밀번호 변경</h2>

								<form class="form-signin" action="updatePassword.jsp"
									method="post">
									<div class="mb-4">
										<!-- 아이디 입력란 -->
										<div class="form-floating">
											<input type="hidden" name="id" value="<%= id %>" />
										</div>
									</div>
									<div class="mb-4">
										<!-- 새 비밀번호 입력란 -->
										<div class="form-floating">
											<input type="password" class="form-control" id="newPassword" name="newPassword"
												required autofocus> <label for="newPassword">새 비밀번호</label>
										</div>
									</div>
									<div class="mb-4">
										<div class="form-floating">
											<!-- 새 비밀번호 확인 입력란 -->
											<input type="password" class="form-control" id="passwordConf"
												name="passwordConf" required> <label for="passwordConf">새 비밀번호 확인</label>
										</div>
									</div>
									<button type="submit" class="btn btn-lg btn-success w-100">비밀번호 변경</button>
								</form>
							</c:when>
							<c:otherwise>
								<h2 class="my-5">일치하는 사용자가 없습니다.</h2>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
			</div>
		</div>
	</section>
	<%@ include file="footer.jsp"%>
</body>
</html>