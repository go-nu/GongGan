<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*, java.io.*" %>
<%@ page import="javax.servlet.*, javax.servlet.http.*, javax.servlet.annotation.*" %>
<%@ include file="dbconn.jsp" %>
<jsp:useBean id="multipartRequest" class="com.oreilly.servlet.MultipartRequest">
    <jsp:setProperty name="multipartRequest" property="*"/>
</jsp:useBean>

<%
    String saveDir = application.getRealPath("/upload");
    int maxSize = 10 * 1024 * 1024; // 10MB
    MultipartRequest multi = new MultipartRequest(request, saveDir, maxSize, "UTF-8");

    String actId = multi.getParameter("ACT_ID");
    String title = multi.getParameter("TITLE");
    int price = Integer.parseInt(multi.getParameter("PRICE"));
    String maxCount = multi.getParameter("MAX_COUNT");
    String actDate = multi.getParameter("ACT_DATE");
    String address = multi.getParameter("ADDRESS");
    String note = multi.getParameter("NOTE");
    String oldImg = multi.getParameter("oldImg");

    String fileName = multi.getFilesystemName("IMG");
    if (fileName == null) fileName = oldImg;

    String sql = "UPDATE fs_semi.activity SET TITLE=?, PRICE=?, IMG=?, MAX_COUNT=?, ACT_DATE=?, ADDRESS=?, NOTE=? WHERE ACT_ID=?";
    PreparedStatement pstmt = conn.prepareStatement(sql);
    pstmt.setString(1, title);
    pstmt.setInt(2, price);
    pstmt.setString(3, fileName);
    pstmt.setInt(4, Integer.parseInt(maxCount));
    pstmt.setString(5, actDate);
    pstmt.setString(6, address);
    pstmt.setString(7, note);
    pstmt.setString(8, actId);

    pstmt.executeUpdate();
    pstmt.close();
    conn.close();

    response.sendRedirect("Admin_FoodActivity.jsp");
%>