<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="dbconn.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	    request.setCharacterEncoding("UTF-8");
	
	    String category = request.getParameter("category");
	    String name = request.getParameter("name");
	    String region = request.getParameter("region");
	    String address = request.getParameter("address");
	    String lat = request.getParameter("lat");
	    String lng = request.getParameter("lng");
	
	    PreparedStatement pstmt = null;
	    String sql = "INSERT INTO map_loc (category, name, region, address, lat, lng) VALUES (?, ?, ?, ?, ?, ?)";
	    pstmt = conn.prepareStatement(sql);
	    pstmt.setString(1, category);
	    pstmt.setString(2, name);
	    pstmt.setString(3, region);
	    pstmt.setString(4, address);
	    pstmt.setString(5, lat);
	    pstmt.setString(6, lng);
	    pstmt.executeUpdate();
	
	    response.sendRedirect("adminPage.jsp");
	%>
</body>
</html>