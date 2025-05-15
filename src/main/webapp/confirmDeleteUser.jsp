<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>회원 탈퇴 확인</title>
    <link rel="stylesheet" href="./resources/css/bootstrap.min.css">
</head>
<body class="container py-5">
    <h3 class="mb-4">회원 탈퇴 확인</h3>
    <form action="processDeleteUser.jsp" method="post">
        <div class="mb-3">
            <label for="password" class="form-label">비밀번호 확인</label>
            <input type="password" name="password" id="password" class="form-control w-25" required>
        </div>
        <button type="submit" class="btn btn-danger">회원 탈퇴</button>
        <a href="MyPage.do" class="btn btn-secondary">취소</a>
    </form>
</body>
</html>
