<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ include file="dbconn.jsp" %>

<%
    request.setCharacterEncoding("UTF-8");

    String rsv_num = request.getParameter("rsv_num");

    String modalMessage = "";
    String modalTitle = "";
    String redirectURL = null;

    if (rsv_num == null || rsv_num.trim().equals("")) {
        modalTitle = "잘못된 접근";
        modalMessage = "예약 번호가 없습니다.";
    } else {
        PreparedStatement pstmt = null;
        try {
            String sql = "DELETE FROM reservation WHERE rsv_num = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, rsv_num);
            int result = pstmt.executeUpdate();

            if (result > 0) {
                modalTitle = "예약 취소 완료";
                modalMessage = "예약이 성공적으로 취소되었습니다.";
                redirectURL = "MyPage.do";
            } else {
                modalTitle = "예약 취소 실패";
                modalMessage = "해당 예약을 찾을 수 없습니다.";
            }
        } catch (Exception e) {
            e.printStackTrace();
            modalTitle = "오류 발생";
            modalMessage = "오류가 발생했습니다. 다시 시도해 주세요.";
        } finally {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>예약 취소 결과</title>
    <link href="./resources/css/bootstrap.min.css" rel="stylesheet">
    <script src="./resources/js/bootstrap.bundle.min.js"></script>
</head>
<body>

<!-- 모달 -->
<div class="modal fade" id="resultModal" tabindex="-1" aria-labelledby="resultModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="resultModalLabel"><%= modalTitle %></h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="닫기"></button>
            </div>
            <div class="modal-body">
                <%= modalMessage %>
            </div>
            <div class="modal-footer border-0">
                <% if (redirectURL != null) { %>
                    <button type="button" class="btn btn-success" onclick="location.href='<%= redirectURL %>'">확인</button>
                <% } else { %>
                    <button type="button" class="btn btn-secondary" onclick="history.back()">확인</button>
                <% } %>
            </div>
        </div>
    </div>
</div>

<script>
    window.addEventListener("DOMContentLoaded", function () {
        const resultModal = new bootstrap.Modal(document.getElementById('resultModal'));
        resultModal.show();
    });
</script>

</body>
</html>
