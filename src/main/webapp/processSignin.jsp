<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%
	request.setCharacterEncoding("UTF-8");
	String id = request.getParameter("id");
	String password = request.getParameter("password");
	String name = request.getParameter("name");
	String gender = request.getParameter("gender");
	String year = request.getParameter("birthyy");
	String month = request.getParameterValues("birthmm")[0];
	String day = request.getParameter("birthdd");
	String birth = year + "-" + month + "-" + day;
	String email1 = request.getParameter("email1");
	String email2 = request.getParameterValues("email2")[0];
	String email = email1 + "@" + email2;
	String phone = request.getParameter("phone");
	String address = request.getParameter("address");
	
	Date currentDatetime = new Date(System.currentTimeMillis());
	java.sql.Date sqlDate = new java.sql.Date(currentDatetime.getTime());
	java.sql.Timestamp timestamp = new java.sql.Timestamp(currentDatetime.getTime());	
%>
<sql:setDataSource var="dataSource"
url="jdbc:mysql://localhost:3306/fs_semi"
driver="com.mysql.jdbc.Driver" user="root" password="1234" />
<sql:update dataSource="${dataSource}" var="resultSet">
	insert into users values(?,?,?,?,?,?,?,?,?)
	<sql:param value="<%=id%>" />
	<sql:param value="<%=password%>" />
	<sql:param value="<%=name%>" />
	<sql:param value="<%=gender%>" />
	<sql:param value="<%=birth%>" />
	<sql:param value="<%=email%>" />
	<sql:param value="<%=phone%>" />
	<sql:param value="<%=address%>" />
	<sql:param value="<%=timestamp%>" />
</sql:update>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원가입 완료</title>
    <link rel="stylesheet" href="./resources/css/bootstrap.min.css">
    <script src="./resources/js/bootstrap.bundle.min.js"></script>
</head>
<body>

<!-- 회원가입 성공 모달 -->
<div class="modal fade" id="signupSuccessModal" tabindex="-1" aria-labelledby="signupSuccessLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="signupSuccessLabel">회원가입 완료</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="닫기"></button>
      </div>
      <div class="modal-body">
        회원가입이 완료되었습니다.
      </div>
      <div class="modal-footer border-0">
        <button type="button" class="btn btn-success" onclick="location.href='index.jsp'">확인</button>
      </div>
    </div>
  </div>
</div>

<script>
    window.addEventListener("DOMContentLoaded", function () {
        new bootstrap.Modal(document.getElementById("signupSuccessModal")).show();
    });
</script>

</body>
</html>