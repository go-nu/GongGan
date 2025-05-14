<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="mvc.model.CosmeticsDTO" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>K-BEAUTY</title>
  <link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/bootstrap.min.css">
  <link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/beauty_style.css">
</head>
<body>

<%@ include file="header.jsp" %>

<!--  상단 이미지 섹션 -->
<section class="hero">
  <div class="carousel-inner">
    <div class="carousel-item active">
      <img src="<%= request.getContextPath() %>/resources/img/BEAUTY09.jpg" class="d-block w-100" alt="K-BEAUTY">
      <div class="fixed-caption">
        <h3>K-BEAUTY</h3>
        <p>Experience the Secrets of Korean Skincare</p>
      </div>
    </div>
  </div>
</section>

<!--  화장품 섹션  -->
<section class="featured-section">
	<div class="container">
    <%
      List<CosmeticsDTO> allCosmetics = (List<CosmeticsDTO>) request.getAttribute("cosmeticsList");

      Map<String, List<CosmeticsDTO>> categorizedCosmetics = new HashMap<>();
      for (CosmeticsDTO cosmetic : allCosmetics) {
        String category = cosmetic.getCategory();
        categorizedCosmetics.computeIfAbsent(category, k -> new ArrayList<>()).add(cosmetic);
      }

      for (Map.Entry<String, List<CosmeticsDTO>> entry : categorizedCosmetics.entrySet()) {
        String categoryName = entry.getKey();
        List<CosmeticsDTO> categoryCosmetics = entry.getValue();
    %>
    <div class="mb-5">
      <div class="d-flex justify-content-between align-items-center mb-3">
        <h4><%= categoryName %></h4>
        <a href="cosmetics?action=category&category=<%= categoryName %>" class="btn btn-sm btn-outline-secondary">더보기(More)</a>
      </div>
      <div class="row row-cols-1 row-cols-md-4 g-4">
        <%
          int displayCount = 0;
          for (CosmeticsDTO cosmetic : categoryCosmetics) {
            if (displayCount++ >= 4) break;
        %>
        <div class="col">
          <div class="card h-100 shadow-sm border-0" style="height: 300px;">
            <img src="<%= request.getContextPath() %>/resources/img/<%= cosmetic.getImage_file() %>" class="card-img-top" alt="<%= cosmetic.getName() %>" style="height: 200px; object-fit: cover;">
            <div class="card-body p-2 text-center" style="height: 110px; overflow: hidden;">
              <h5 class="card-title mb-2"><%= cosmetic.getName() %></h5>
              <p class="card-text small text-muted mb-2">주요 성분: <%= cosmetic.getMain_ingredient() %></p>
              <a href="cosmetics?action=detail&id=<%= cosmetic.getId() %>" class="btn btn-sm btn-outline-primary">상세보기</a>
            </div>
          </div>
        </div>
        <% } %>
      </div>
    </div>
    <% } %>
  </div>
</section>

<!--  중단 -->
<section class="about-section">
  	<div class="container text-center py-5">
    <h4 class="text-muted">상단</h4>
    </div>
</section>

<!-- 하단 -->
<section class="class-section">
  <div class="container text-center py-5">
    <h4 class="text-muted">하단</h4>
  </div>
</section>

<%@ include file="footer.jsp" %>
<script src="<%= request.getContextPath() %>/resources/js/bootstrap.bundle.min.js"></script>
</body>
</html>
