<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ include file="dbconn.jsp" %>
<%
	request.setCharacterEncoding("UTF-8");
	String newPassword = request.getParameter("newPassword");
	String id = request.getParameter("id");
%>
<sql:update dataSource="${dataSource}" var="resultSet">
	update users set password = ? where id = ?
	<sql:param value="<%=newPassword%>" />
	<sql:param value="<%=id%>" />
</sql:update>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>비밀번호 변경 완료</title>
	<link href="./resources/css/bootstrap.min.css" rel="stylesheet">
	<script src="./resources/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<!-- 부트스트랩 모달 -->
	<div class="modal fade" id="passwordChangeModal" tabindex="-1" aria-labelledby="passwordChangeLabel" aria-hidden="true">
	  	<div class="modal-dialog">
	    	<div class="modal-content">
	      		<div class="modal-header">
	        		<h5 class="modal-title" id="passwordChangeLabel">비밀번호 변경 완료</h5>
	        		<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="닫기"></button>
	      		</div>
	      		<div class="modal-body">
	        		비밀번호가 변경되었습니다.
	      		</div>
	      		<div class="modal-footer border-0">
	        		<button type="button" class="btn btn-success" onclick="redirectToLogin()">확인</button>
	      		</div>
	    	</div>
	  	</div>
	</div>

	<script>
		function redirectToLogin() {
			window.location.href = 'login.jsp';
		}
		window.addEventListener("DOMContentLoaded", function () {
			const modal = new bootstrap.Modal(document.getElementById('passwordChangeModal'));
			modal.show();
		});
	</script>
</body>
</html>