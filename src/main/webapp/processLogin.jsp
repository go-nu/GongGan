<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.sql.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ include file="dbconn.jsp" %>
<%
	request.setCharacterEncoding("UTF-8");
	String id = request.getParameter("id");
	String password = request.getParameter("password");
	
	// 리다이렉션 URL 처리
	String redirectAfterLogin = (String) session.getAttribute("redirectAfterLogin");
	if (redirectAfterLogin == null || redirectAfterLogin.contains("login.jsp")) {
	    redirectAfterLogin = "index.jsp";
	}
%>

<sql:query dataSource="${dataSource}" var="resultSet">
    select * from users where id = ? and password = ?
    <sql:param value="<%= id %>" />
    <sql:param value="<%= password %>" />
</sql:query>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>로그인 처리</title>
    <link rel="stylesheet" href="./resources/css/bootstrap.min.css">
    <script src="./resources/js/bootstrap.bundle.min.js"></script>
</head>
<body>

<c:choose>
    <c:when test="${not empty resultSet.rows}">
        <!-- 로그인 성공: 세션 저장 후 이동 -->
        <c:set var="user" value="${resultSet.rows[0]}" />

        <c:set scope="session" var="id" value="${user.id}" />
        <c:set scope="session" var="name" value="${user.name}" />
        <c:set scope="session" var="gender" value="${user.gender}" />
        <c:set scope="session" var="birth" value="${user.birth}" />
        <c:set scope="session" var="email" value="${user.email}" />
        <c:set scope="session" var="phone" value="${user.phone}" />
        <c:set scope="session" var="address" value="${user.address}" />
      <!-- 로그인 성공 모달 -->
        <div class="modal fade" id="loginSuccessModal" tabindex="-1" aria-labelledby="loginSuccessLabel" aria-hidden="true">
          <div class="modal-dialog">
            <div class="modal-content">
              <div class="modal-header">
                <h5 class="modal-title" id="loginSuccessLabel">로그인 성공</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="닫기"></button>
              </div>
              <div class="modal-body">
                로그인에 성공하였습니다.
              </div>
              <div class="modal-footer border-0">
                <button type="button" class="btn btn-primary" onclick="location.href='<%= redirectAfterLogin %>'">확인</button>
              </div>
            </div>
          </div>
        </div>

        <script>
            window.addEventListener("DOMContentLoaded", function () {
                new bootstrap.Modal(document.getElementById("loginSuccessModal")).show();
            });
        </script>
    </c:when>

    <c:otherwise>
        <!-- 로그인 실패 모달 -->
        <div class="modal fade" id="loginFailModal" tabindex="-1" aria-labelledby="loginFailLabel" aria-hidden="true">
          <div class="modal-dialog">
            <div class="modal-content">
              <div class="modal-header">
                <h5 class="modal-title" id="loginFailLabel">로그인 실패</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="닫기"></button>
              </div>
              <div class="modal-body">
                아이디 또는 비밀번호가 일치하지 않습니다.
              </div>
              <div class="modal-footer border-0">
                <button type="button" class="btn btn-danger" onclick="location.href='login.jsp'">확인</button>
              </div>
            </div>
          </div>
        </div>

        <script>
            window.addEventListener("DOMContentLoaded", function () {
                new bootstrap.Modal(document.getElementById("loginFailModal")).show();
            });
        </script>
    </c:otherwise>
</c:choose>
</body>
</html>
