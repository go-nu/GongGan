<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="mvc.model.CosmeticsDTO" %>
<!DOCTYPE html>
<html>
<head>    
<meta charset="UTF-8">
<title>상품 수정</title>
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
      <h3 class="mb-4 text-start">상품 수정</h3>

      <%
        CosmeticsDTO cosmetic = (CosmeticsDTO) request.getAttribute("cosmetic");
        if (cosmetic != null) {
      %>

      <form action="cosmetics?action=update" method="post" enctype="multipart/form-data" class="needs-validation" novalidate>
        <input type="hidden" name="id" value="<%= cosmetic.getId() %>">
        <input type="hidden" name="image_file" value="<%= cosmetic.getImage_file() %>">

        <div class="form-left-side">
          <div class="form-row-custom">
            <div class="form-col">
              <label for="name" class="form-label">제품명</label>
              <input type="text" class="form-control" name="name" id="name" value="<%= cosmetic.getName() %>" required>
            </div>
            <div class="form-col">
              <label for="brand" class="form-label">브랜드</label>
              <input type="text" class="form-control" name="brand" id="brand" value="<%= cosmetic.getBrand() %>" required>
            </div>
          </div>

        
          <div class="form-row-custom">
            <div class="form-col">
              <label for="price" class="form-label">가격</label>
              <input type="number" class="form-control" name="price" id="price" value="<%= cosmetic.getPrice() %>" required>
            </div>
            <div class="form-col">
              <label for="category" class="form-label">카테고리</label>
              <select class="form-select" name="category" id="category" required>
                <option value="">카테고리 선택</option>
                <option value="색조화장" <%= cosmetic.getCategory().equals("색조화장") ? "selected" : "" %>>색조화장</option>
                <option value="바디용품" <%= cosmetic.getCategory().equals("바디용품") ? "selected" : "" %>>바디용품</option>
                <option value="헤어용품" <%= cosmetic.getCategory().equals("헤어용품") ? "selected" : "" %>>헤어용품</option>
                <option value="기초화장" <%= cosmetic.getCategory().equals("기초화장") ? "selected" : "" %>>기초화장</option>
              </select>
            </div>
          </div>

          
          <div class="form-row-custom">
            <div class="form-col">
              <label for="main_ingredient" class="form-label">주요 성분</label>
              <input type="text" class="form-control" name="main_ingredient" id="main_ingredient" value="<%= cosmetic.getMain_ingredient() %>" required>
            </div>
            <div class="form-col">
              <label for="effect" class="form-label">효능</label>
              <input type="text" class="form-control" name="effect" id="effect" value="<%= cosmetic.getEffect() %>" required>
            </div>
          </div>

       
          <div class="form-row-custom">
            <div class="form-col">
              <label for="image_file" class="form-label">새 이미지 (선택)</label>
              <input type="file" class="form-control" name="image_file_upload" id="image_file" accept="image/*" onchange="previewLocalImage(this);">
            </div>
            <div class="form-col"></div>
          </div>
        </div>

        <!-- 오른쪽 미리보기 박스 -->
        <div class="preview-container">
          <div id="imagePreviewContainer">
            <img id="imagePreview" src="<%= request.getContextPath() %>/resources/img/<%= cosmetic.getImage_file() %>" alt="미리보기">
          </div>
        </div>

        <div class="text-end">
          <button type="submit" class="btn btn-primary">수정 완료</button>
          <a href="cosmetics?action=adminlist" class="btn btn-secondary">취소</a>
        </div>
      </form>

      <% } else { %>
        <div class="alert alert-warning">수정할 제품 정보를 불러오지 못했습니다.</div>
      <% } %>
    </div>
  </div>
</section>

<section class="white-space"></section>

<%@ include file="footer.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
