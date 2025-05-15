<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="mvc.model.CosmeticsDTO" %>
<%@ page import="mvc.model.CosmeticsDAO" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>K-BEAUTY 카테고리</title>
  <link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/bootstrap.min.css">
  <link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/beauty_style.css">
</head>
<body>
<%@ include file="header.jsp" %>

<!-- 상단 이미지 섹션 -->
<section class="hero">
  <div class="carousel-inner">
    <div class="carousel-item active">
      <img src="<%= request.getContextPath() %>/resources/img/BEAUTY08.jpg" class="d-block w-100" alt="K-BEAUTY">
      <div class="fixed-caption">
        <h3>K-BEAUTY</h3>
        <p>Explore Your Favorite Korean Skincare Category</p>
      </div>
    </div>
  </div>
</section>

<!-- 화장품 카테고리 -->
<section class="featured-section">
  <div class="container">
    <% 
      String category = request.getParameter("category");
      if (category == null || category.isEmpty()) {
          category = "전체";
      }
      CosmeticsDAO cosmeticsRepository = CosmeticsDAO.getInstance();
      List<CosmeticsDTO> cosmeticsList = cosmeticsRepository.getCosmeticsByCategory(category);

      int itemsPerPage = 16;
      int totalItems = cosmeticsList.size();
      int totalPages = (int) Math.ceil((double) totalItems / itemsPerPage);

      String pageParam = request.getParameter("page");
      int currentPage = (pageParam != null && !pageParam.isEmpty()) ? Integer.parseInt(pageParam) : 1;

      int startIndex = (currentPage - 1) * itemsPerPage;
      int endIndex = Math.min(startIndex + itemsPerPage, totalItems);
    %>

    <h3 class="mb-3 text-start"><%= category %></h3>
    <div class="row row-cols-1 row-cols-md-4 gy-5 gx-4">
      <% for (int i = startIndex; i < endIndex; i++) {
        CosmeticsDTO cosmetic = cosmeticsList.get(i); %>
        <div class="col">
          <div class="card h-100 shadow-sm border-0" style="height: 300px;">
            <img src="<%= request.getContextPath() %>/resources/img/<%= cosmetic.getImage_file() %>" class="card-img-top" alt="<%= cosmetic.getName() %>" style="height: 200px; object-fit: cover;">
            <div class="card-body p-2 text-center" style="height: 120px; overflow: hidden;">
              <h5 class="card-title mb-2"><%= cosmetic.getName() %></h5>
              <p class="card-text small text-muted mb-2">주요 성분: <%= cosmetic.getMain_ingredient() %></p>
              <div style="font-size: 12px; color: #d33; line-height: 1; margin-bottom: 6px;">
			  ❤️ <span style="font-size: 12px; color: #333;"><%= cosmetic.getLikes() %></span>
			  </div>
              <a href="cosmetics?action=detail&id=<%= cosmetic.getId() %>" class="btn btn-sm btn-outline-primary">상세보기</a>
            </div>	
          </div>
        </div>
      <% } %>
    </div>

    <!-- 페이지 네비게이션 -->
    <nav aria-label="Page navigation example" class="mt-4">
      <ul class="pagination justify-content-center">
        <li class="page-item <%= (currentPage == 1) ? "disabled" : "" %>">
          <a class="page-link" href="?category=<%= category %>&page=<%= currentPage - 1 %>">이전</a>
        </li>
        <% for (int i = 1; i <= totalPages; i++) { %>
          <li class="page-item <%= (i == currentPage) ? "active" : "" %>">
            <a class="page-link" href="?category=<%= category %>&page=<%= i %>"><%= i %></a>
          </li>
        <% } %>
        <li class="page-item <%= (currentPage == totalPages) ? "disabled" : "" %>">
          <a class="page-link" href="?category=<%= category %>&page=<%= currentPage + 1 %>">다음</a>
        </li>
      </ul>
    </nav>
  </div>
</section>

<!-- 중단 -->
<section class="about-section">
  	 <div class="container text-center py-5">
     <h4 class="text-muted">중단 섹션</h4>
     </div>
</section>

<!-- 하단 -->
<section class="class-section">
  <div class="container text-center py-5">
    <h4 class="text-muted">하단 섹션</h4>
  </div>
</section>

<%@ include file="footer.jsp" %>
<script src="<%= request.getContextPath() %>/resources/js/bootstrap.bundle.min.js"></script>
</body>
</html>
