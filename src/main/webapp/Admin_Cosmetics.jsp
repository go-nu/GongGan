<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="mvc.model.CosmeticsDTO" %>
<%@ page import="mvc.model.CosmeticsDAO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 상품 관리</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
<link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/beauty_style.css">
<script src="<%= request.getContextPath() %>/resources/js/dday.js"></script>
</head>
<body>
<%@ include file="header.jsp" %>

	<!--  메인 이미지 섹션 -->
		<section class="hero">
		  <div class="carousel-inner">
		    <div class="carousel-item active">
		      <img src="<%= request.getContextPath() %>/resources/img/BEAUTY05.jpg" class="d-block w-100" alt="관리자 상품 관리">
		      <div class="fixed-caption">
		        <h3>상품 관리</h3>
		        <p>관리자 전용 상품 페이지</p>
		      </div>
		    </div>
		  </div>
		</section>
    
    <div class="container">	

      <div class="d-flex justify-content-between align-items-center mb-4 mt-4">
        <h2 class="ml-0" style="margin-top: 30px;">관리자 상품 목록</h2>

        <div class="d-flex align-items-center gap-2">
          <form method="get" action="Admin_Cosmetics.jsp" class="d-flex align-items-center gap-2 m-0">
            <select name="category" class="form-select" style="width: 180px; height: 38px; font-size: 14px;">
              <option value="">전체</option>
              <option value="바디용품">바디용품</option>
              <option value="기초화장">기초화장</option>
              <option value="색조화장">색조화장</option>
              <option value="헤어용품">헤어용품</option>
            </select>
            <button type="submit" class="btn btn-outline-primary" style="height: 38px; font-size: 14px;">카테고리 필터</button>
          </form>

          <a href="AddCosmetics.jsp" class="btn btn-sm btn-outline-primary" style="height: 38px; font-size: 14px;">상품 등록</a>
        </div>
      </div>

      <%
        String categoryFilter = request.getParameter("category");
        String pageParam = request.getParameter("page");

        int currentPage = (pageParam != null && !pageParam.isEmpty()) ? Integer.parseInt(pageParam) : 1;
        int itemsPerPage = 16;

        List<CosmeticsDTO> allCosmetics = new ArrayList<>();
        CosmeticsDAO cosmeticsRepository = CosmeticsDAO.getInstance();

        if (categoryFilter != null && !categoryFilter.isEmpty()) {
            allCosmetics = cosmeticsRepository.getCosmeticsByCategory(categoryFilter);
        } else {
            allCosmetics = cosmeticsRepository.getAllCosmetics();
        }

        int totalItems = allCosmetics.size();
        int totalPages = (int) Math.ceil((double) totalItems / itemsPerPage);
        int startIndex = (currentPage - 1) * itemsPerPage;
        int endIndex = Math.min(startIndex + itemsPerPage, totalItems);
      %>

      <div class="row row-cols-1 row-cols-md-4 gy-5 gx-4">
        <% for (int i = startIndex; i < endIndex; i++) {
        	CosmeticsDTO cosmetic = allCosmetics.get(i);
        %>
        <div class="col">
          <div class="card h-100 shadow-sm border-0">
            <img src="<%= request.getContextPath() %>/resources/img/<%= cosmetic.getImage_file() %>" class="card-img-top" alt="<%= cosmetic.getName() %>" style="height: 200px; object-fit: cover;">
            <div class="card-body p-2 text-center">
              <h5 class="card-title mb-2"><%= cosmetic.getName() %></h5>
              <div class="d-flex justify-content-center gap-2">
                <a href="cosmetics?action=edit&id=<%= cosmetic.getId() %>" class="btn btn-sm btn-outline-success">수정</a>
                <a href="cosmetics?action=deleteform&id=<%= cosmetic.getId() %>" class="btn btn-sm btn-outline-danger">삭제</a>
              </div>
            </div>
          </div>
        </div>
        <% } %>
      </div>

      <!--  페이지네이션 -->
      <nav aria-label="Page navigation" class="mt-4 mb-4">
        <ul class="pagination justify-content-center">
          <li class="page-item <%= (currentPage == 1) ? "disabled" : "" %>">
            <a class="page-link" href="Admin_Cosmetics.jsp?page=<%= currentPage - 1 %><%= categoryFilter != null ? "&category=" + categoryFilter : "" %>">이전</a>
          </li>

          <% for (int i = 1; i <= totalPages; i++) { %>
            <li class="page-item <%= (i == currentPage) ? "active" : "" %>">
              <a class="page-link" href="Admin_Cosmetics.jsp?page=<%= i %><%= categoryFilter != null ? "&category=" + categoryFilter : "" %>"><%= i %></a>
            </li>
          <% } %>

          <li class="page-item <%= (currentPage == totalPages) ? "disabled" : "" %>">
            <a class="page-link" href="Admin_Cosmetics.jsp?page=<%= currentPage + 1 %><%= categoryFilter != null ? "&category=" + categoryFilter : "" %>">다음</a>
          </li>
        </ul>
      </nav>

    </div> <!-- container 끝 -->

<%@ include file="footer.jsp" %>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
