<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>관리자 오류</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
  <link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/CrudCosmetics_style.css">
</head>
<body>

<%@ include file="header.jsp" %>

<section class="white-space"></section>

<section class="bg-image">
  <div class="overlay">
    <div class="container pt-5 pb-5 text-center">
      <h2 class="mb-4 text-danger">🚫 관리자 처리 중 오류 발생</h2>
      <p class="fs-5 text-warning">
        <%= request.getAttribute("error") != null ? request.getAttribute("error") : "알 수 없는 오류가 발생했습니다." %>
      </p>

      <div class="mt-4">
        <a href="cosmetics?action=adminlist" class="btn btn-outline-primary me-2">관리자 목록으로 돌아가기</a>
      </div>
    </div>
  </div>
</section>

<section class="white-space"></section>

<%@ include file="footer.jsp" %>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
