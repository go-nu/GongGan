<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>관리자 로그인</title>
</head>
<body>
    <h2>관리자 로그인</h2>
    <form method="post" action="j_security_check">
        <label>ID: <input type="text" name="j_username" /></label><br>
        <label>Password: <input type="password" name="j_password" /></label><br>
        <input type="submit" value="로그인" />
    </form>
</body>
</html>