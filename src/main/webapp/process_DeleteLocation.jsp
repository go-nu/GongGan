<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ include file="dbconn.jsp" %>
<%
request.setCharacterEncoding("UTF-8");
String table = request.getParameter("table");
String id = request.getParameter("id");

boolean success = false;

try {
    String sql = "DELETE FROM " + table + " WHERE " + ("city".equals(table) ? "city_num" : "id") + " = ?";
    PreparedStatement pstmt = conn.prepareStatement(sql);
    pstmt.setInt(1, Integer.parseInt(id));
    int result = pstmt.executeUpdate();
    success = result > 0;
    pstmt.close();
    conn.close();
} catch (Exception e) {
    out.println("<script>alert('삭제 중 오류 발생: " + e.getMessage() + "'); history.back();</script>");
}
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>삭제 완료</title>
    <link href="./resources/css/bootstrap.min.css" rel="stylesheet">
    <script src="./resources/js/bootstrap.bundle.min.js"></script>
</head>
<body>
    <!-- 삭제 완료 모달 -->
    <div class="modal fade" id="deleteSuccessModal" tabindex="-1" aria-labelledby="deleteSuccessLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="deleteSuccessLabel">삭제 완료</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="닫기"></button>
                </div>
                <div class="modal-body">
                    삭제가 완료되었습니다.
                </div>
                <div class="modal-footer border-0">
                    <button type="button" class="btn btn-success" onclick="location.href='ManageLocation.jsp'">확인</button>
                </div>
            </div>
        </div>
    </div>

    <script>
        window.addEventListener("DOMContentLoaded", function () {
            const modal = new bootstrap.Modal(document.getElementById("deleteSuccessModal"));
            modal.show();
        });
    </script>
</body>
</html>