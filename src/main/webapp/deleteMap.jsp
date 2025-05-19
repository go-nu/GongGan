<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="dbconn.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>GONGGAN</title>
</head>
<body>
	<%
	    request.setCharacterEncoding("UTF-8");
	    String id = request.getParameter("id");
	
	    PreparedStatement pstmt = null;
	    String sql = "DELETE FROM map_loc WHERE id=?";
	    pstmt = conn.prepareStatement(sql);
	    pstmt.setString(1, id);
	    pstmt.executeUpdate();
	    response.sendRedirect("adminPage.jsp");
	%>

</body>
</html>