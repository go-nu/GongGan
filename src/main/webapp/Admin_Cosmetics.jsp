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

<section class="bg-image" style="padding-top: 100px;">
  <div class="overlay">
   <div class="d-flex justify-content-between align-items-center mb-4">
  <h2 class="ml-0">관리자 상품 목록</h2>

  <div class="d-flex align-items-center gap-2">
    <form method="get" action="" class="d-flex align-items-center gap-2 m-0">
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

    <div class="row row-cols-1 row-cols-md-4 gy-5 gx-4">
      <% 
        // 카테고리 필터링 로직
        String categoryFilter = request.getParameter("category");
        List<Cosmetics> cosmeticsList = new ArrayList<>();
        
        CosmeticsRepository cosmeticsRepository = CosmeticsRepository.getInstance();
        
        // 카테고리 값이 있다면 필터 적용
        if (categoryFilter != null && !categoryFilter.isEmpty()) {
            cosmeticsList = cosmeticsRepository.getCosmeticsByCategory(categoryFilter);
        } else {
            cosmeticsList = cosmeticsRepository.getAllCosmetics(); // 전체 목록 조회
        }
        
        // 상품 출력
        for (Cosmetics cosmetic : cosmeticsList) {
      %>

      <!-- 상품 카드 -->
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
    </div> <!-- 상품 목록 끝 -->
  </div> <!-- overlay 끝 -->
</section> <!-- section 끝 -->

<%@ include file="footer.jsp" %>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
