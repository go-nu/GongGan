<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*"%>
<%@ page import="java.nio.file.*"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ include file="dbconn.jsp"%>

<%
String savePath = application.getRealPath("/resources/img");
int maxSize = 20 * 1024 * 1024; // 20MB
String encoding = "UTF-8";

MultipartRequest multi = new MultipartRequest(request, savePath, maxSize, encoding, null);

String filename = multi.getParameter("filename");
String title = multi.getParameter("title");
String note = multi.getParameter("note");
String tag1 = multi.getParameter("tag1");
String tag2 = multi.getParameter("tag2");
String tag3 = multi.getParameter("tag3");
String tag4 = multi.getParameter("tag4");
String tag5 = multi.getParameter("tag5");

if ("null".equalsIgnoreCase(tag1)) tag1 = null;
if ("null".equalsIgnoreCase(tag2)) tag2 = null;
if ("null".equalsIgnoreCase(tag3)) tag3 = null;
if ("null".equalsIgnoreCase(tag4)) tag4 = null;
if ("null".equalsIgnoreCase(tag5)) tag5 = null;

String message = null;
String redirectURL = null;
boolean isSuccess = false;

PreparedStatement stmt = null;
String newFilename = filename;

if (conn != null) {
    try {
        File uploadedFile = multi.getFile("newfilename");
        if (uploadedFile != null) {
            File targetFile = new File(savePath + File.separator + filename);
            if (targetFile.exists()) targetFile.delete();
            if (!uploadedFile.renameTo(targetFile)) {
                message = "파일 저장에 실패했습니다.";
                redirectURL = "editPage.jsp";
            }
        }

        if (message == null) {
            String sql = "UPDATE main SET TITLE = ?, NOTE = ?, TAG1 = ?, TAG2 = ?, TAG3 = ?, TAG4 = ?, TAG5 = ?, FILENAME = ? WHERE FILENAME = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, title);
            stmt.setString(2, note);
            stmt.setString(3, tag1);
            stmt.setString(4, tag2);
            stmt.setString(5, tag3);
            stmt.setString(6, tag4);
            stmt.setString(7, tag5);
            stmt.setString(8, newFilename);
            stmt.setString(9, filename);

            int rowsUpdated = stmt.executeUpdate();
            if (rowsUpdated > 0) {
                message = "슬라이드 정보가 성공적으로 수정되었습니다.";
                redirectURL = "index.jsp";
                isSuccess = true;
            } else {
                message = "수정 실패. 해당 파일을 찾을 수 없습니다.";
                redirectURL = "editPage.jsp";
            }
        }
    } catch (Exception e) {
        message = "오류 발생: " + e.getMessage();
        redirectURL = "editPage.jsp";
    } finally {
        try { if (stmt != null) stmt.close(); if (conn != null) conn.close(); } catch (SQLException e) {}
    }
} else {
    message = "DB 연결 실패!";
    redirectURL = "editPage.jsp";
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
<div class="modal fade" id="resultModal" tabindex="-1" aria-labelledby="resultModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="resultModalLabel"><%= isSuccess ? "수정 완료" : "오류 발생" %></h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="닫기"></button>
            </div>
            <div class="modal-body">
                <%= message %>
            </div>
            <div class="modal-footer border-0">
                <button type="button" class="btn <%= isSuccess ? "btn-primary" : "btn-danger" %>" onclick="location.href='<%= redirectURL %>'">확인</button>
            </div>
        </div>
    </div>
</div>
<script>
    window.addEventListener("DOMContentLoaded", function () {
        new bootstrap.Modal(document.getElementById("resultModal")).show();
    });
</script>
</body>
</html>
