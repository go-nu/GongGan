<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, java.io.*" %>
<%@ include file="dbconn.jsp" %>

<%
    request.setCharacterEncoding("UTF-8");

    String actId = request.getParameter("ACT_ID");

    if (actId == null || actId.trim().equals("")) {
        out.println("<script>alert('삭제할 활동 ID가 없습니다.'); history.back();</script>");
        return;
    }

    // 삭제 전 기존 이미지 파일명 확인
    String imgFile = null;
    String selectSql = "SELECT IMG FROM fs_semi.activity WHERE ACT_ID = ?";
    PreparedStatement pstmtSelect = conn.prepareStatement(selectSql);
    pstmtSelect.setString(1, actId);
    ResultSet rs = pstmtSelect.executeQuery();
    if (rs.next()) {
        imgFile = rs.getString("IMG");
    }
    rs.close();
    pstmtSelect.close();

    // DB에서 삭제
    String deleteSql = "DELETE FROM fs_semi.activity WHERE ACT_ID = ?";
    PreparedStatement pstmtDelete = conn.prepareStatement(deleteSql);
    pstmtDelete.setString(1, actId);
    int result = pstmtDelete.executeUpdate();
    pstmtDelete.close();

    // 이미지 삭제
    if (result > 0 && imgFile != null && !imgFile.isEmpty()) {
        String uploadPath = application.getRealPath("/upload");
        File imageFile = new File(uploadPath, imgFile);
        if (imageFile.exists()) {
            imageFile.delete(); // 서버 이미지 삭제
        }
    }

    conn.close();
    response.sendRedirect("admin_FoodActivity.jsp");
%>
