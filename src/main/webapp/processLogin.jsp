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
%>

<sql:query dataSource="${dataSource}" var="resultSet">
    select * from users where id = ? and password = ?
    <sql:param value="<%= id %>" />
    <sql:param value="<%= password %>" />
</sql:query>

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
		<%
		    String redirectAfterLogin = (String) session.getAttribute("redirectAfterLogin");
		    if (redirectAfterLogin == null || redirectAfterLogin.contains("login.jsp")) {
		        redirectAfterLogin = "index.jsp"; // fallback
		    }
		%>
        <script>
            alert("로그인에 성공하였습니다.");
            location.href = "<%= redirectAfterLogin %>"
            conn.close();
        </script>
    </c:when>
    <c:otherwise>
        <!-- 로그인 실패 -->
        <script>
            alert("아이디 또는 비밀번호가 일치하지 않습니다.");
            location.href = "login.jsp"; // 로그인 실패 시 다시 로그인 페이지로 이동
        </script>
    </c:otherwise>
</c:choose>
