<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ include file="dbconn.jsp" %>
<%
    String actId = request.getParameter("ACT_ID");
    String sql = "DELETE FROM fs_semi.activity WHERE ACT_ID = ?";
    PreparedStatement pstmt = conn.prepareStatement(sql);
    pstmt.setString(1, actId);
    pstmt.executeUpdate();
    pstmt.close();
    conn.close();
    response.sendRedirect("Admin_FoodActivity.jsp");
%>