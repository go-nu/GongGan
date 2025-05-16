<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ include file="dbconn.jsp" %>

<%
    request.setCharacterEncoding("UTF-8");

    String actId = request.getParameter("ACT_ID");

    if (actId == null || actId.trim().equals("")) {
        out.println("<script>alert('삭제할 활동 ID가 없습니다.'); history.back();</script>");
        return;
    }
    
    // 1. 예약 내역이 있는지 먼저 확인
    String checkSql = "SELECT COUNT(*) FROM fs_semi.reservation WHERE act_id = ?";
    PreparedStatement checkStmt = conn.prepareStatement(checkSql);
    checkStmt.setString(1, actId);
    ResultSet checkRs = checkStmt.executeQuery();

    if (checkRs.next()) {
        int reservationCount = checkRs.getInt(1);
        if (reservationCount > 0) {
            checkRs.close();
            checkStmt.close();
            conn.close();
            out.println("<script>alert('해당 체험 활동에 예약 내역이 있어 삭제할 수 없습니다.'); history.back();</script>");
            return;
        }
    }
    checkRs.close();
    checkStmt.close();

    // DB에서 삭제
    String deleteSql = "DELETE FROM fs_semi.activity WHERE ACT_ID = ?";
    PreparedStatement pstmtDelete = conn.prepareStatement(deleteSql);
    pstmtDelete.setString(1, actId);
    int result = pstmtDelete.executeUpdate();
    pstmtDelete.close();

    conn.close();
%>
<%
    String returnURL = request.getParameter("returnURL");
    if (returnURL == null || returnURL.trim().isEmpty()) {
        returnURL = "admin_FoodActivity.jsp"; // 기본값
    }
%>
<script>
    alert("삭제가 완료되었습니다.");
    location.href = "<%= returnURL %>";
</script>