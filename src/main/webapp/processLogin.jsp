<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ include file="dbconn.jsp" %>
<%
	request.setCharacterEncoding("UTF-8");
	String id = request.getParameter("id");
	String password = request.getParameter("password");
	
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	boolean loginSuccess = false;
	
	String sql = "SELECT * FROM users WHERE id = ? AND password = ?";
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, id);
	pstmt.setString(2, password);
	rs = pstmt.executeQuery();
	
	if (rs.next()) {
	    // 로그인 성공
	    session.setAttribute("sessionId", id);
	    loginSuccess = true;
	}
	
	if (loginSuccess) {
%>
	<script>
        alert("로그인에 성공하였습니다.");
        location.href = "index.jsp";
    </script>
<%
	} else {
%>
    <script>
        alert("아이디 또는 비밀번호가 일치하지 않습니다.");
        location.href = "login.jsp";
    </script>
<%
	}
%>
