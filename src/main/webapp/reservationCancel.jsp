<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ include file="dbconn.jsp" %>

<%
    String rsv_num = request.getParameter("rsv_num");

    if (rsv_num == null || rsv_num.trim().equals("")) {
        out.println("<script>alert('잘못된 접근입니다.'); history.back();</script>");
        return;
    }

    PreparedStatement pstmt = null;
    try {
        String sql = "DELETE FROM reservation WHERE rsv_num = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, rsv_num);
        int result = pstmt.executeUpdate();

        if (result > 0) {
            out.println("<script>alert('예약이 취소되었습니다.'); location.href='MyPage.do';</script>");
        } else {
            out.println("<script>alert('해당 예약을 찾을 수 없습니다.'); history.back();</script>");
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<script>alert('오류가 발생했습니다.'); history.back();</script>");
    } finally {
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }
%>
