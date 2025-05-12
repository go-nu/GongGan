<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ include file="dbconn.jsp" %>
<%
	request.setCharacterEncoding("UTF-8");
	String name = request.getParameter("name");
	String phone = request.getParameter("phone");
	request.setAttribute("name", name);
%>
<sql:query dataSource="${dataSource}" var="result">
	select id from users where name = ? and phone = ?
	<sql:param value="<%=name%>" />
	<sql:param value="<%=phone%>" />
</sql:query>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
					<c:choose>
						<c:when test="${not empty result.rows}">
							<c:forEach var="row" items="${result.rows}">
								<h2 class="my-5">${name}님의 ID는 ${row.id}입니다.</h2>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<h2 class="my-5">일치하는 사용자가 없습니다.</h2>
						</c:otherwise>
					</c:choose>
					<%conn.close(); %>
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
<%@ include file="footer.jsp" %>
</body>
</html>