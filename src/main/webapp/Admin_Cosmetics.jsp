<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="dto.Cosmetics" %>
<%@ page import="dao.CosmeticsRepository" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 상품 관리</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
<link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/beautyList_style.css">
<script src="<%= request.getContextPath() %>/resources/js/dday.js"></script>
</head>
<body>
<%@ include file="header.jsp" %>

<section class="bg-image">
  <div class="overlay">
    <div class="container pt-5 pb-3">
      <h3 class="mb-4 text-start">관리자 상품 목록</h3>
      <div class="row row-cols-1 row-cols-md-4 gy-5 gx-4">

        <%
          CosmeticsRepository cosmeticsRepository = CosmeticsRepository.getInstance();
          List<Cosmetics> cosmeticsList = cosmeticsRepository.getAllCosmetics(); // 모든 상품 조회

          for (Cosmetics cosmetic : cosmeticsList) {
        %>

        <!-- 상품 카드 -->
        <div class="col">
          <div class="card h-100 shadow-sm border-0">
            <img src="<%= request.getContextPath() %>/resources/img/<%= cosmetic.getImage_file() %>" class="card-img-top" alt="<%= cosmetic.getName() %>" style="height: 200px; object-fit: cover;">
            <div class="card-body p-2 text-center">
              <h5 class="card-title mb-2"><%= cosmetic.getName() %></h5>
              <div class="d-flex justify-content-center gap-2">
                <a href="UpdateCosmetics.jsp?id=<%= cosmetic.getId() %>" class="btn btn-sm btn-outline-success">수정</a>
                <a href="DeleteCosmetics.jsp?id=<%= cosmetic.getId() %>" class="btn btn-sm btn-outline-danger">삭제</a>
              </div>
            </div>
          </div>
        </div>

        <% } %>

      </div>
    </div>
  </div>
</section>

<%@ include file="footer.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
