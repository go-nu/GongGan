<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="mvc.model.CosmeticsDTO" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>상품 삭제</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/CrudCosmetics_style.css">
</head>
<body>

<%@ include file="header.jsp" %>

<section class="white-space"></section>

<section class="bg-image">
  <div class="overlay">
    <div class="container pt-5 pb-5">
      <h3 class="mb-4 text-start">상품 삭제 확인</h3>

      <%
        CosmeticsDTO cosmetic = (CosmeticsDTO) request.getAttribute("cosmetic");
        if (cosmetic != null) {
      %>

      <form action="cosmetics?action=delete" method="post">
        <input type="hidden" name="id" value="<%= cosmetic.getId() %>">

        <div class="form-left-side">
          <div class="form-row-custom">
            <div class="form-col">
              <label class="form-label">제품명</label>
              <input type="text" class="form-control" value="<%= cosmetic.getName() %>" readonly>
            </div>
            <div class="form-col">
              <label class="form-label">브랜드</label>
              <input type="text" class="form-control" value="<%= cosmetic.getBrand() %>" readonly>
            </div>
          </div>

         
          <div class="form-row-custom">
            <div class="form-col">
              <label class="form-label">가격</label>
              <input type="text" class="form-control" value="<%= cosmetic.getPrice() %>" readonly>
            </div>
            <div class="form-col">
              <label class="form-label">카테고리</label>
              <input type="text" class="form-control" value="<%= cosmetic.getCategory() %>" readonly>
            </div>
          </div>

        
          <div class="form-row-custom">
            <div class="form-col">
              <label class="form-label">주요 성분</label>
              <input type="text" class="form-control" value="<%= cosmetic.getMain_ingredient() %>" readonly>
            </div>
            <div class="form-col">
              <label class="form-label">효능</label>
              <input type="text" class="form-control" value="<%= cosmetic.getEffect() %>" readonly>
            </div>
          </div>

          
          <div class="form-row-custom">
            <div class="form-col">
              <label class="form-label">이미지 파일</label>
              <input type="text" class="form-control" value="<%= cosmetic.getImage_file() %>" readonly>
            </div>
            <div class="form-col"></div>
          </div>
        </div>

        <!-- 우측 이미지 미리보기 -->
        <div class="preview-container">
          <div id="imagePreviewContainer">
            <img src="<%= request.getContextPath() %>/resources/img/<%= cosmetic.getImage_file() %>" alt="미리보기" id="imagePreview">
          </div>
        </div>

        <div class="text-end">
          <button type="submit" class="btn btn-danger">삭제 확인</button>
          <a href="cosmetics?action=adminlist" class="btn btn-secondary">취소</a>
        </div>
      </form>

      <% } else { %>
        <div class="alert alert-warning" role="alert">
          해당 ID의 상품 정보를 찾을 수 없습니다.
        </div>
      <% } %>
    </div>
  </div>
</section>

<%@ include file="footer.jsp" %>
</body>
</html>
