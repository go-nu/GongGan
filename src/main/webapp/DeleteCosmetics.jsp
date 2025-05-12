<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.Cosmetics" %>
<%@ page import="dao.CosmeticsRepository" %>
<%
    String idParam = request.getParameter("id");
    Cosmetics cosmetic = null;
    if (idParam != null && !idParam.isEmpty()) {
        try {
            int id = Integer.parseInt(idParam);
            CosmeticsRepository repo = CosmeticsRepository.getInstance();
            cosmetic = repo.getCosmeticsById(id);
        } catch (NumberFormatException e) {
            // 유효하지 않은 ID 형식 처리
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>상품 삭제 확인</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/AddCosmetics_style.css">
    <script src="<%= request.getContextPath() %>/resources/js/dday.js"></script>
</head>
<body>
<%@ include file="header.jsp" %>

<section class="bg-image pt-5">
  <div class="overlay">
    <div class="container pt-5 pb-5">
      <h3 class="mb-4 text-start">상품 삭제 확인</h3>
      <%
        if (cosmetic != null) {
      %>
      <form action="process_DeleteCosmetics.jsp" method="post" class="needs-validation" novalidate>
        <input type="hidden" name="id" value="<%= cosmetic.getId() %>">
        
        <div class="mb-3">
          <label class="form-label">제품명</label>
          <input type="text" class="form-control" value="<%= cosmetic.getName() %>" readonly>
        </div>
        
        <div class="mb-3">
          <label class="form-label">브랜드</label>
          <input type="text" class="form-control" value="<%= cosmetic.getBrand() %>" readonly>
        </div>
        
        <div class="mb-3">
          <label class="form-label">가격</label>
          <input type="text" class="form-control" value="<%= cosmetic.getPrice() %>" readonly>
        </div>
        
        <div class="mb-3">
          <label class="form-label">주요 성분</label>
          <input type="text" class="form-control" value="<%= cosmetic.getMain_ingredient() %>" readonly>
        </div>
        
        <div class="mb-3">
          <label class="form-label">효능</label>
          <input type="text" class="form-control" value="<%= cosmetic.getEffect() %>" readonly>
        </div>
        
        <div class="mb-3">
          <label class="form-label">카테고리</label>
          <input type="text" class="form-control" value="<%= cosmetic.getCategory() %>" readonly>
        </div>
        
        <div class="mb-3">
          <label class="form-label">현재 이미지</label><br>
          <img src="<%= request.getContextPath() %>/resources/images/<%= cosmetic.getImage_file() %>" alt="제품 이미지" style="max-width: 200px;">
        </div>
        
        <div class="text-end">
          <button type="submit" class="btn btn-danger">삭제</button>
          <a href="beautyList.jsp" class="btn btn-secondary">취소</a>
        </div>
      </form>
      <%
        } else {
      %>
      <div class="alert alert-warning" role="alert">
        해당 ID의 제품을 찾을 수 없습니다.
      </div>
      <%
        }
      %>
    </div>
  </div>
</section>

<%@ include file="footer.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
