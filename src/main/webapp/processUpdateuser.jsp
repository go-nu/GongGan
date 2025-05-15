<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ include file="dbconn.jsp" %>

<%
    request.setCharacterEncoding("UTF-8");

    String sessionId = (String) session.getAttribute("id");
    String name = request.getParameter("name");
    String gender = request.getParameter("gender");
    String birth = request.getParameter("birth");
    String email = request.getParameter("email");
    String phone = request.getParameter("phone");
    String address = request.getParameter("address");
    String password = request.getParameter("password");
    String confirmPassword = request.getParameter("confirmPassword");

    String newPassword = null;
    boolean changePassword = false;

    // 비밀번호 입력 여부 및 일치 확인
    if (password != null && !password.trim().isEmpty()) {
        if (password.equals(confirmPassword)) {
            newPassword = password;
            changePassword = true;
        } else {
            out.println("<script>alert('비밀번호와 비밀번호 확인이 일치하지 않습니다.'); history.back();</script>");
            return;
        }
    }

    PreparedStatement pstmt = null;
    if (changePassword) {
        String sql = "UPDATE users SET name=?, gender=?, birth=?, email=?, phone=?, address=?, password=? WHERE id=?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, name);
        pstmt.setString(2, gender);
        pstmt.setString(3, birth);
        pstmt.setString(4, email);
        pstmt.setString(5, phone);
        pstmt.setString(6, address);
        pstmt.setString(7, newPassword);  // 새 비밀번호
        pstmt.setString(8, sessionId);
    } else {
        String sql = "UPDATE users SET name=?, gender=?, birth=?, email=?, phone=?, address=? WHERE id=?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, name);
        pstmt.setString(2, gender);
        pstmt.setString(3, birth);
        pstmt.setString(4, email);
        pstmt.setString(5, phone);
        pstmt.setString(6, address);
        pstmt.setString(7, sessionId);
    }

    int result = pstmt.executeUpdate();

    if (result > 0) {
        // 세션 정보도 최신으로 반영
        session.setAttribute("name", name);
        session.setAttribute("gender", gender);
        session.setAttribute("birth", birth);
        session.setAttribute("email", email);
        session.setAttribute("phone", phone);
        session.setAttribute("address", address);
        out.println("<script>alert('정보가 성공적으로 수정되었습니다.'); location.href='MyPage.do';</script>");
    } else {
        out.println("<script>alert('정보 수정에 실패했습니다.'); history.back();</script>");
    }

    if (pstmt != null) pstmt.close();
    if (conn != null) conn.close();
%>
