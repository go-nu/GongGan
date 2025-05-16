<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // 세션 무효화
    session.invalidate();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>로그아웃</title>
    <link href="./resources/css/bootstrap.min.css" rel="stylesheet">
    <script src="./resources/js/bootstrap.bundle.min.js"></script>
</head>
<body>

<!-- 로그아웃 모달 -->
<div class="modal fade" id="logoutModal" tabindex="-1" aria-labelledby="logoutLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="logoutLabel">로그아웃</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                로그아웃 되었습니다.
            </div>
            <div class="modal-footer border-0">
                <button type="button" class="btn btn-primary" onclick="redirectHome()">확인</button>
            </div>
        </div>
    </div>
</div>

<script>
    function redirectHome() {
        window.location.href = "index.jsp";
    }

    window.addEventListener("DOMContentLoaded", function () {
        const modal = new bootstrap.Modal(document.getElementById("logoutModal"));
        modal.show();
    });
</script>
</body>
</html>
