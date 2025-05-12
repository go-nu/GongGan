<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.oreilly.servlet.*" %>
<%@ page import="com.oreilly.servlet.multipart.*" %>
<%@ include file="dbconn.jsp" %>

<%
request.setCharacterEncoding("UTF-8");

String savePath = application.getRealPath("/resources/img");  // 업로드 폴더
int maxSize = 5 * 1024 * 1024;  // 5MB
String encoding = "UTF-8";

MultipartRequest multi = new MultipartRequest(request, savePath, maxSize, encoding, new DefaultFileRenamePolicy());

String name = multi.getParameter("name");
String brand = multi.getParameter("brand");
int price = Integer.parseInt(multi.getParameter("price"));
String mainIngredient = multi.getParameter("main_ingredient");
String effect = multi.getParameter("effect");
String category = multi.getParameter("category");
String imageFile = multi.getFilesystemName("image_file");  // 실제 저장된 파일 이름

PreparedStatement pstmt = null;
String sql = "INSERT INTO cosmetics (name, brand, price, main_ingredient, effect, category, image_file) VALUES (?, ?, ?, ?, ?, ?, ?)";
	
try {
    pstmt = conn.prepareStatement(sql);
    pstmt.setString(1, name);
    pstmt.setString(2, brand);
    pstmt.setInt(3, price);
    pstmt.setString(4, mainIngredient);
    pstmt.setString(5, effect);
    pstmt.setString(6, category);
    pstmt.setString(7, imageFile);
    pstmt.executeUpdate();

    response.sendRedirect("beautyList.jsp");  // 등록 후 목록으로 이동
} catch (SQLException e) {
    out.println("DB 오류: " + e.getMessage());
} finally {
    if (pstmt != null) pstmt.close();
    if (conn != null) conn.close();
}
%>
