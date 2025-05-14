<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="dto.Cosmetics" %>
<%@ page import="dao.CosmeticsRepository" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cosmetics</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
<link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/beautyList_style.css">
</head>
<body>
<%@ include file="header.jsp" %>

<!-- 메인 이미지 -->
<div class="container-fluid p-0 text-center" style="position: relative;">
  <img src="./resources/img/BEAUTY08.jpg" class="img-fluid mx-auto" alt="Your Image Description" style="width: 1400px; height: 600px;">
  <div class="text-overlay" style="position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); color: white; font-size: 40px; font-weight: bold; text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);">
    Experience the Secrets of Korean Skincare
  </div>
</div>

<!-- 상품 목록 -->
<section class="bg-image">
  <div class="overlay pt-1 pb-1">
    <div class="container pt-3 pb-3">
        <% 
          // 카테고리 값 가져오기
          String category = request.getParameter("category");
          if (category == null || category.isEmpty()) {
              category = "전체";  // 카테고리가 없으면 "전체"로 설정
          }
          
          // CosmeticsRepository에서 카테고리별 화장품 리스트 가져오기
          CosmeticsRepository cosmeticsRepository = CosmeticsRepository.getInstance();
          List<Cosmetics> cosmeticsList = cosmeticsRepository.getCosmeticsByCategory(category);

          int itemsPerPage = 16;
          int totalItems = cosmeticsList.size();
          int totalPages = (int) Math.ceil((double) totalItems / itemsPerPage);

          String pageParam = request.getParameter("page");
          int currentPage = (pageParam != null && !pageParam.isEmpty()) ? Integer.parseInt(pageParam) : 1;

          int startIndex = (currentPage - 1) * itemsPerPage;
          int endIndex = Math.min(startIndex + itemsPerPage, totalItems);
        %>

        <h3 class="mb-4 text-start"><%= category %></h3>
        <div class="row row-cols-1 row-cols-md-4 gy-5 gx-4">
          <% for (int i = startIndex; i < endIndex; i++) {
              Cosmetics cosmetic = cosmeticsList.get(i);
          %>

        <!-- 카드 -->
        <div class="col">
          <div class="card h-100 shadow-sm border-0" style="height: 300px;">
            <img src="<%= request.getContextPath() %>/resources/img/<%= cosmetic.getImage_file() %>" class="card-img-top" alt="<%= cosmetic.getName() %>" style="height: 200px; object-fit: cover;">
            <div class="card-body p-2 text-center" style="height: 110px; overflow: hidden;">
              <h5 class="card-title mb-2"><%= cosmetic.getName() %></h5>
              <p class="card-text small text-muted mb-2">주요 성분: <%= cosmetic.getMain_ingredient() %></p>
              <div class="d-flex justify-content-end gap-3 small text-muted mb-2">
                <a href="cosmetics?action=detail&id=<%= cosmetic.getId() %>" class="btn btn-sm btn-outline-primary">상세보기</a>
              </div>
            </div>
          </div>
        </div>

        <% } %>
      </div>
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

  </div> <!-- overlay 끝 -->
</section> <!-- section 끝 -->

<%@ include file="footer.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
