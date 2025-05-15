<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ include file="dbconn.jsp" %>

<%
    request.setCharacterEncoding("UTF-8");
    String sessionId = (String) session.getAttribute("id");
    String inputPassword = request.getParameter("password");

    if (sessionId == null || inputPassword == null || inputPassword.trim().isEmpty()) {
        out.println("<script>alert('잘못된 요청입니다.'); history.back();</script>");
        return;
    }

    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
    	// ✅ 예약 존재 여부 확인
    	String checkReservationSql = "SELECT COUNT(*) FROM reservation WHERE id = ?";
    	pstmt = conn.prepareStatement(checkReservationSql);
    	pstmt.setString(1, sessionId);
    	rs = pstmt.executeQuery();

    	if (rs.next() && rs.getInt(1) > 0) {
    	    out.println("<script>alert('예약 내역이 존재합니다. 먼저 예약을 취소해주세요.'); location.href='MyPage.do';</script>");
    	    return;
    	}

    	rs.close();
    	pstmt.close();

        // 1. 사용자 비밀번호 조회
        String sql = "SELECT password FROM users WHERE id = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, sessionId);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            String dbPassword = rs.getString("password");

            if (!inputPassword.equals(dbPassword)) {
                out.println("<script>alert('비밀번호가 일치하지 않습니다.'); history.back();</script>");
            } else {
                rs.close();
                pstmt.close();

                // 2. 사용자 삭제
                String deleteSql = "DELETE FROM users WHERE id = ?";
                pstmt = conn.prepareStatement(deleteSql);
                pstmt.setString(1, sessionId);
                int result = pstmt.executeUpdate();

                if (result > 0) {
                    session.invalidate();
                    out.println("<script>alert('회원 탈퇴가 완료되었습니다.'); location.href='index.jsp';</script>");
                } else {
                    out.println("<script>alert('회원 탈퇴에 실패했습니다.'); history.back();</script>");
                }
            }
        } else {
            out.println("<script>alert('사용자 정보가 없습니다.'); history.back();</script>");
        }
    } catch (Exception e) {
        e.printStackTrace(); // 서버 콘솔에 에러 출력
        out.println("<script>alert('오류가 발생했습니다.'); history.back();</script>");
    } finally {
        if (rs != null) try { rs.close(); } catch (Exception ex) {}
        if (pstmt != null) try { pstmt.close(); } catch (Exception ex) {}
        if (conn != null) try { conn.close(); } catch (Exception ex) {}
    }
%>
