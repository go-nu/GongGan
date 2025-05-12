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

<%-- JSP 내부에서 alert 사용 --%>
<script>
    alert('비밀번호 변경이 완료되었습니다.');
    window.location.href = 'login.jsp';
    conn.close();
</script>