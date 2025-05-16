<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ include file="dbconn.jsp" %>
<%
    request.setCharacterEncoding("UTF-8");
    String sessionId = (String) session.getAttribute("id");
    String inputPassword = request.getParameter("password");

    String message = null;
    String redirectURL = null;

    if (sessionId == null || inputPassword == null || inputPassword.trim().isEmpty()) {
        message = "잘못된 요청입니다.";
    } else {
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            // ✅ 예약 존재 여부 확인
            String checkReservationSql = "SELECT COUNT(*) FROM reservation WHERE id = ?";
            pstmt = conn.prepareStatement(checkReservationSql);
            pstmt.setString(1, sessionId);
            rs = pstmt.executeQuery();

            if (rs.next() && rs.getInt(1) > 0) {
                message = "예약 내역이 존재합니다. 먼저 예약을 취소해주세요.";
                redirectURL = "MyPage.do";
            } else {
                rs.close();
                pstmt.close();

                // 사용자 비밀번호 조회
                String sql = "SELECT password FROM users WHERE id = ?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, sessionId);
                rs = pstmt.executeQuery();

                if (rs.next()) {
                    String dbPassword = rs.getString("password");

                    if (!inputPassword.equals(dbPassword)) {
                        message = "비밀번호가 일치하지 않습니다.";
                    } else {
                        rs.close();
                        pstmt.close();

                        // 사용자 삭제
                        String deleteSql = "DELETE FROM users WHERE id = ?";
                        pstmt = conn.prepareStatement(deleteSql);
                        pstmt.setString(1, sessionId);
                        int result = pstmt.executeUpdate();

                        if (result > 0) {
                            session.invalidate();
                            message = "회원 탈퇴가 완료되었습니다.";
                            redirectURL = "index.jsp";
                        } else {
                            message = "회원 탈퇴에 실패했습니다.";
                        }
                    }
                } else {
                    message = "사용자 정보가 없습니다.";
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            message = "오류가 발생했습니다.";
        } finally {
            if (rs != null) try { rs.close(); } catch (Exception ex) {}
            if (pstmt != null) try { pstmt.close(); } catch (Exception ex) {}
            if (conn != null) try { conn.close(); } catch (Exception ex) {}
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>처리 결과</title>
    <link href="./resources/css/bootstrap.min.css" rel="stylesheet">
    <script src="./resources/js/bootstrap.bundle.min.js"></script>
</head>
<body>
    <!-- 부트스트랩 모달 -->
    <div class="modal fade" id="alertModal" tabindex="-1" aria-labelledby="alertModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="alertModalLabel">알림</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="닫기"></button>
                </div>
                <div class="modal-body">
                    <%= message %>
                </div>
                <div class="modal-footer border-0">
                    <button type="button" class="btn btn-primary" onclick="handleRedirect()">확인</button>
                </div>
            </div>
        </div>
    </div>

    <script>
        function handleRedirect() {
            <% if (redirectURL != null) { %>
                location.href = '<%= redirectURL %>';
            <% } else { %>
                history.back();
            <% } %>
        }

        window.addEventListener("DOMContentLoaded", function () {
            const modal = new bootstrap.Modal(document.getElementById("alertModal"));
            modal.show();
        });
    </script>
</body>
</html>
