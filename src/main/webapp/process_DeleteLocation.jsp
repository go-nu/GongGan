<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ include file="dbconn.jsp" %>
<%
request.setCharacterEncoding("UTF-8");
String table = request.getParameter("table");
String id = request.getParameter("id");

try {
    String column = "";
    if ("city".equals(table)) {
        column = "city_num";
    } else if ("city_district".equals(table)) {
        column = "id";
    } else {
        throw new Exception("잘못된 테이블 요청입니다.");
    }

    String sql = "DELETE FROM " + table + " WHERE " + column + " = ?";
    PreparedStatement pstmt = conn.prepareStatement(sql);
    pstmt.setInt(1, Integer.parseInt(id));
    int result = pstmt.executeUpdate();
%>
    <script>
        alert("삭제가 완료되었습니다.");
        location.href = "ManageLocation.jsp";
    </script>
<%
} catch (Exception e) {
    out.println("<script>alert('삭제 중 오류 발생: " + e.getMessage().replaceAll("'", "") + "'); history.back();</script>");
}
%>
