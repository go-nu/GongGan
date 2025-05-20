<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, java.io.*, java.util.*" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ include file="dbconn.jsp" %>

<%
	String redirectURL = request.getRequestURI();
	String queryString = request.getQueryString();
	if (queryString != null) {
	    redirectURL += "?" + queryString;
	}
	String encodedRedirect = java.net.URLEncoder.encode(redirectURL, "UTF-8");
    boolean isSuccess = false;
    String errorMessage = "활동 등록 중 오류가 발생했습니다.";

    try {
	    String savePath = application.getRealPath("/resources/img");
	    int maxSize = 10 * 1024 * 1024;
	    MultipartRequest multi = new MultipartRequest(request, savePath, maxSize, "UTF-8", new DefaultFileRenamePolicy());
	
	    // 필드값 가져오기
	    String title     = multi.getParameter("TITLE");
	    String img       = multi.getFilesystemName("image_file_upload");
	    int maxCount     = Integer.parseInt(multi.getParameter("MAX_COUNT"));
	    String actDate   = multi.getParameter("ACT_DATE");
	    String address   = multi.getParameter("ADDRESS");
	    String note      = multi.getParameter("NOTE");
	
	    // ACT_ID 생성 (랜덤 8자리 영숫자)
	    String actId = "A" + UUID.randomUUID().toString().replaceAll("-", "").substring(0, 7).toUpperCase();
	
	    String sql = "INSERT INTO fs_semi.activity (ACT_ID, TITLE, IMG, MAX_COUNT, ACT_DATE, ADDRESS, NOTE) VALUES (?, ?, ?, ?, ?, ?, ?)";
	    PreparedStatement pstmt = conn.prepareStatement(sql);
	    pstmt.setString(1, actId);
	    pstmt.setString(2, title);
	    pstmt.setString(3, img);
	    pstmt.setInt(4, maxCount);
	    pstmt.setString(5, actDate);
	    pstmt.setString(6, address);
	    pstmt.setString(7, note);
	
	    int result = pstmt.executeUpdate();
	    pstmt.close();
	    conn.close();
	    if (result > 0) isSuccess = true;
	
	} catch (Exception e) {
	    errorMessage = e.getMessage(); // 또는 사용자 친화적인 메시지로 변경 가능
	}
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>등록 결과</title>
    <link href="./resources/css/bootstrap.min.css" rel="stylesheet">
    <script src="./resources/js/bootstrap.bundle.min.js"></script>
</head>
<body>
<% if (isSuccess) { %>
<!-- ✅ 등록 성공 모달 -->
<div class="modal fade" id="successModal" tabindex="-1" aria-labelledby="successLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="successLabel">등록 완료</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="닫기"></button>
            </div>
            <div class="modal-body">
                활동이 등록되었습니다.
            </div>
            <div class="modal-footer border-0">
                <button type="button" class="btn btn-success" onclick="location.href='admin_FoodActivity.jsp?redirect=<%= encodedRedirect %>'">확인</button>
            </div>
        </div>
    </div>
</div>
<% } else { %>
<!-- ❌ 등록 실패 모달 -->
<div class="modal fade" id="failModal" tabindex="-1" aria-labelledby="failLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="failLabel">등록 실패</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="닫기"></button>
            </div>
            <div class="modal-body">
                활동 등록 중 오류가 발생했습니다.
            </div>
            <div class="modal-footer border-0">
                <button type="button" class="btn btn-danger" onclick="history.back()">확인</button>
            </div>
        </div>
    </div>
</div>
<% } %>
<script>
    window.addEventListener("DOMContentLoaded", function () {
        const success = document.getElementById("successModal");
        const fail = document.getElementById("failModal");
        if (success) new bootstrap.Modal(success).show();
        if (fail) new bootstrap.Modal(fail).show();
    });
</script>

</body>
</html>
