<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ include file="dbconn.jsp" %>
<%
    request.setCharacterEncoding("UTF-8");

    String actId = request.getParameter("ACT_ID");
    String returnURL = request.getParameter("returnURL");
    if (returnURL == null || returnURL.trim().isEmpty()) {
        returnURL = "admin_FoodActivity.jsp";
    }

    boolean showNoIdModal = false;
    boolean showHasReservationModal = false;
    boolean showDeleteSuccessModal = false;

    if (actId == null || actId.trim().equals("")) {
        showNoIdModal = true;
    } else {
        // 예약 내역 확인
        String checkSql = "SELECT COUNT(*) FROM fs_semi.reservation WHERE act_id = ?";
        PreparedStatement checkStmt = conn.prepareStatement(checkSql);
        checkStmt.setString(1, actId);
        ResultSet checkRs = checkStmt.executeQuery();

        if (checkRs.next() && checkRs.getInt(1) > 0) {
            showHasReservationModal = true;
        }else {
            // 먼저 sub_img 테이블에서 참조 데이터 삭제
            String deleteSubImgSql = "DELETE FROM fs_semi.sub_img WHERE act_id = ?";
            PreparedStatement pstmtSubImg = conn.prepareStatement(deleteSubImgSql);
            pstmtSubImg.setString(1, actId);
            pstmtSubImg.executeUpdate();
            pstmtSubImg.close();

            // 그런 다음 activity에서 삭제
            String deleteActivitySql = "DELETE FROM fs_semi.activity WHERE ACT_ID = ?";
            PreparedStatement pstmtActivity = conn.prepareStatement(deleteActivitySql);
            pstmtActivity.setString(1, actId);
            pstmtActivity.executeUpdate();
            pstmtActivity.close();

            showDeleteSuccessModal = true;
        }

        checkRs.close();
        checkStmt.close();
    }
    if (conn != null) conn.close();
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>삭제 상태</title>
    <link href="./resources/css/bootstrap.min.css" rel="stylesheet">
    <script src="./resources/js/bootstrap.bundle.min.js"></script>
</head>
<body>

<!-- 삭제할 ID 없음 -->
<div class="modal fade" id="noIdModal" tabindex="-1" aria-labelledby="noIdLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="noIdLabel">삭제 오류</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">삭제할 활동 ID가 없습니다.</div>
            <div class="modal-footer border-0">
                <button type="button" class="btn btn-danger" onclick="history.back()">확인</button>
            </div>
        </div>
    </div>
</div>

<!-- 예약 존재 시 삭제 불가 -->
<div class="modal fade" id="hasReservationModal" tabindex="-1" aria-labelledby="hasReservationLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="hasReservationLabel">삭제 불가</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">해당 체험 활동에 예약 내역이 있어 삭제할 수 없습니다.</div>
            <div class="modal-footer border-0">
                <button type="button" class="btn btn-danger" onclick="history.back()">확인</button>
            </div>
        </div>
    </div>
</div>

<!-- 삭제 성공 -->
<div class="modal fade" id="deleteSuccessModal" tabindex="-1" aria-labelledby="deleteSuccessLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="deleteSuccessLabel">삭제 완료</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">해당 활동이 삭제되었습니다.</div>
            <div class="modal-footer border-0">
                <button type="button" class="btn btn-success" onclick="location.href='adminPage.jsp'">확인</button>
            </div>
        </div>
    </div>
</div>

<script>
    function redirect() {
        location.href = "<%= returnURL %>";
    }

    window.addEventListener("DOMContentLoaded", function () {
        <% if (showNoIdModal) { %>
        new bootstrap.Modal(document.getElementById("noIdModal")).show();
        <% } else if (showHasReservationModal) { %>
        new bootstrap.Modal(document.getElementById("hasReservationModal")).show();
        <% } else if (showDeleteSuccessModal) { %>
        new bootstrap.Modal(document.getElementById("deleteSuccessModal")).show();
        <% } %>
    });
</script>

</body>
</html>
