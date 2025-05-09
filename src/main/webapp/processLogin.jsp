<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%
request.setCharacterEncoding("UTF-8");
String id = request.getParameter("id");
String password = request.getParameter("password");
%>
<sql:setDataSource var="dataSource"
	url="jdbc:mysql://localhost:3306/semi_projectdb"
	driver="com.mysql.jdbc.Driver" user="root" password="1234" />
<sql:query dataSource="${dataSource}" var="resultSet">
	select * from users where id = ? and password = ?
	<sql:param value="<%=id%>" />
	<sql:param value="<%=password%>" />
</sql:query>

<c:choose>
	<c:when test="${not empty resultSet.rows}">
		<%-- 로그인 성공: 세션 저장 후 이동 --%>
		<%
		session.setAttribute("sessionId", id);
		%>
		<script>
			alert("로그인에 성공하였습니다.");
			location.href = "index.jsp"; // 이동할 페이지
		</script>
	</c:when>
	<c:otherwise>
		<%-- 로그인 실패 --%>
		<script>
			alert("아이디 또는 비밀번호가 일치하지 않습니다.");
			location.href = "login.jsp";
		</script>
	</c:otherwise>
</c:choose>