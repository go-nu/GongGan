<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>    
<meta charset="UTF-8">
<title>상품추가</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
<link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/CrudCosmetics_style.css">
<script src="<%= request.getContextPath() %>/resources/js/imagePreview.js"></script>
</head>
<body>
<%@ include file="header.jsp" %>

<section class="white-space"></section>

<section class="bg-image">
  <div class="overlay">
    <div class="container pt-5 pb-5">	
      <h3 class="mb-4 text-start">상품 등록</h3>
      <form action="cosmetics?action=add" method="post" enctype="multipart/form-data" class="needs-validation" novalidate>
        <div class="form-left-side">
          <div class="form-row-custom">
      <div class="form-col">
        <label for="name" class="form-label">제품명</label>
        <input type="text" class="form-control" name="name" id="name" required>
      </div>
      <div class="form-col">
        <label for="brand" class="form-label">브랜드</label>
        <input type="text" class="form-control" name="brand" id="brand" required>
      </div>
    </div>

   
    <div class="form-row-custom">
      <div class="form-col">
        <label for="price" class="form-label">가격</label>
        <input type="number" class="form-control" name="price" id="price" required>
      </div>
      <div class="form-col">
        <label for="category" class="form-label">카테고리</label>
        <select class="form-select" name="category" id="category" required>
          <option value="">카테고리 선택</option>
          <option value="색조화장">색조화장</option>
          <option value="바디용품">바디용품</option>
          <option value="헤어용품">헤어용품</option>
          <option value="기초화장">기초화장</option>
        </select>
      </div>
    </div>

   
    <div class="form-row-custom">
      <div class="form-col">
        <label for="main_ingredient" class="form-label">주요 성분</label>
        <input type="text" class="form-control" name="main_ingredient" id="main_ingredient" required>
      </div>
      <div class="form-col">
        <label for="effect" class="form-label">효능</label>
        <input type="text" class="form-control" name="effect" id="effect" required>
      </div>
    </div>

    
    <div class="form-row-custom">
      <div class="form-col">
        <label for="image_file" class="form-label">이미지 파일</label>
        <input type="file" class="form-control" name="image_file" id="image_file" accept="image/*" onchange="previewLocalImage(this);" required>
      </div>
      <div class="form-col"><!-- 비워둠 --></div>
    </div>
  </div>

  <!-- 우측 미리보기 -->
  <div class="preview-container">
    <div id="imagePreviewContainer">
      <img id="imagePreview" src="<%= request.getContextPath() %>/resources/img/no_image.jpg" alt="미리보기" style="display: block;">
    </div>
  </div>

  <div class="text-end">
    <button type="submit" class="btn btn-primary">등록</button>
  </div>
</form>
    </div>
  </div>
</section>

<section class="white-space"></section>

<%@ include file="footer.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
