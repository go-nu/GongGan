<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, java.io.*, java.util.*" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ include file="dbconn.jsp" %>

<%

    String savePath = application.getRealPath("/resources/img");  // 업로드 디렉토리
    int maxSize = 10 * 1024 * 1024; // 최대 10MB
    String encoding = "UTF-8";

    MultipartRequest multi = new MultipartRequest(
        request,
        savePath,
        maxSize,
        encoding,
        new DefaultFileRenamePolicy()
    );

    String actId     = multi.getParameter("ACT_ID");
    String title     = multi.getParameter("TITLE");
    int price        = Integer.parseInt(multi.getParameter("PRICE"));
    int maxCount     = Integer.parseInt(multi.getParameter("MAX_COUNT"));
    String actDate   = multi.getParameter("ACT_DATE");
    String address   = multi.getParameter("ADDRESS");
    String note      = multi.getParameter("NOTE");

    String oldImg    = multi.getParameter("oldImg");
    String newImg    = multi.getFilesystemName("image_file_upload");

    String finalImg = (newImg != null) ? newImg : oldImg;

    String sql = "UPDATE fs_semi.activity SET TITLE=?, PRICE=?, IMG=?, MAX_COUNT=?, ACT_DATE=?, ADDRESS=?, NOTE=? WHERE ACT_ID=?";

    PreparedStatement pstmt = conn.prepareStatement(sql);
    pstmt.setString(1, title);
    pstmt.setInt(2, price);
    pstmt.setString(3, finalImg);
    pstmt.setInt(4, maxCount);
    pstmt.setString(5, actDate);
    pstmt.setString(6, address);
    pstmt.setString(7, note);
    pstmt.setString(8, actId);

    int result = pstmt.executeUpdate();

    pstmt.close();
    conn.close();

	String returnURL = multi.getParameter("returnURL");
	if (returnURL == null || returnURL.trim().equals("")) {
	    returnURL = "admin_FoodActivity.jsp";  // 기본 경로
	}
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>수정 결과</title>
    <link href="./resources/css/bootstrap.min.css" rel="stylesheet">
    <script src="./resources/js/bootstrap.bundle.min.js"></script>
</head>
<body>

<% if (result > 0) { %>
<!-- 수정 성공 모달 -->
<div class="modal fade" id="successModal" tabindex="-1" aria-labelledby="successLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="successLabel">수정 완료</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="닫기"></button>
            </div>
            <div class="modal-body">
                체험 정보가 수정되었습니다.
            </div>
            <div class="modal-footer border-0">
                <button type="button" class="btn btn-success" onclick="location.href='<%= returnURL %>'">확인</button>
            </div>
        </div>
    </div>
</div>

<script>
    window.addEventListener("DOMContentLoaded", function () {
        new bootstrap.Modal(document.getElementById("successModal")).show();
    });
</script>

<% } else { %>
<!-- 수정 실패 모달 -->
<div class="modal fade" id="failModal" tabindex="-1" aria-labelledby="failLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="failLabel">수정 실패</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="닫기"></button>
            </div>
            <div class="modal-body">
                체험 정보 수정에 실패했습니다.
            </div>
            <div class="modal-footer border-0">
                <button type="button" class="btn btn-danger" onclick="history.back()">확인</button>
            </div>
        </div>
    </div>
</div>

<script>
    window.addEventListener("DOMContentLoaded", function () {
        new bootstrap.Modal(document.getElementById("failModal")).show();
    });
</script>
<% } %>

</body>
</html>