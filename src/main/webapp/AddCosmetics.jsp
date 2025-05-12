<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>	
<meta charset="UTF-8">
<title>상품추가</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
<link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/AddCosmetics_style.css">
<script src="<%= request.getContextPath() %>/resources/js/dday.js"></script>
</head>
<body>
<%@ include file="header.jsp" %>


<!-- 배경 이미지 섹션 -->
<section class="bg-image pt-5">
  <div class="overlay">

    <!-- 상품 추가 폼 -->
<div class="container pt-5 pb-5">
  <h3 class="mb-4 text-start">상품 등록</h3>
  <form action="process_AddCosmetics.jsp" method="post" enctype="multipart/form-data" class="needs-validation" novalidate>
    
    <div class="mb-3">
      <label for="name" class="form-label">제품명</label>
      <input type="text" class="form-control" name="name" id="name" required>
    </div>
    
    <div class="mb-3">
      <label for="brand" class="form-label">브랜드</label>
      <input type="text" class="form-control" name="brand" id="brand" required>
    </div>
    
    <div class="mb-3">
      <label for="price" class="form-label">가격</label>
      <input type="number" class="form-control" name="price" id="price" required>
    </div>
    
    <div class="mb-3">
      <label for="main_ingredient" class="form-label">주요 성분</label>
      <input type="text" class="form-control" name="main_ingredient" id="main_ingredient" required>
    </div>
    
    <div class="mb-3">
      <label for="effect" class="form-label">효능</label>
      <input type="text" class="form-control" name="effect" id="effect" required>
    </div>
    
    <div class="mb-3">
      <label for="category" class="form-label">카테고리</label>
      <select class="form-select" name="category" id="category" required>
        <option value="">카테고리 선택</option>
        <option value="스킨케어">스킨케어</option>
        <option value="아이템">아이템</option>
        <option value="토너">토너</option>
        <option value="파운데이션">파운데이션</option>
      </select>
    </div>
    
    <div class="mb-3">
      <label for="image_file" class="form-label">제품 이미지 파일</label>
      <input type="file" class="form-control" name="image_file" id="image_file" accept="image/*" required>
    </div>

    <div class="text-end">
      <button type="submit" class="btn btn-primary">등록</button>
    </div>

  </form>
</div>
    
  </div> <!-- overlay 끝 -->
</section> <!-- section 끝 -->

<%@ include file="footer.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
