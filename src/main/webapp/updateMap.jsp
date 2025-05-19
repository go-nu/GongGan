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
	    String name = request.getParameter("name");
	    String category = request.getParameter("category");
	    String region = request.getParameter("region");
	    String address = request.getParameter("address");
	    String lat = request.getParameter("lat");
	    String lng = request.getParameter("lng");
	
	    PreparedStatement pstmt = null;
	    String sql = "UPDATE map_loc SET category=?, name=?, region=?, address=?, lat=?, lng=? WHERE id=?";
	    pstmt = conn.prepareStatement(sql);
	    pstmt.setString(1, category);
	    pstmt.setString(2, name);
	    pstmt.setString(3, region);
	    pstmt.setString(4, address);
	    pstmt.setString(5, lat);
	    pstmt.setString(6, lng);
	    pstmt.setString(7, id);
	    pstmt.executeUpdate();
	    response.sendRedirect("adminPage.jsp");
	%>
</body>
</html>