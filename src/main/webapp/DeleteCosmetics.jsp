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
    <title>상품 삭제</title>
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
      <h2 class="mb-4 text-start">상품 삭제</h2>
      <%
        if (cosmetic != null) {
      %>
      <form action="process_DeleteCosmetics.jsp" method="post" class="needs-validation" novalidate>
        <input type="hidden" name="id" value="<%= cosmetic.getId() %>">

        <div class="form-row-custom">
          <div class="form-col">
            <label class="form-label">제품명</label>
            <input type="text" class="form-control" value="<%= cosmetic.getName() %>" readonly>
          </div>
          <div class="form-col">
            <label class="form-label">브랜드</label>
            <input type="text" class="form-control" value="<%= cosmetic.getBrand() %>" readonly>
          </div>
          <div class="form-col">
            <div id="imagePreviewContainer">
              <img id="imagePreview" src="<%= request.getContextPath() %>/resources/img/<%= cosmetic.getImage_file() %>" alt="현재 이미지">
            </div>
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
          <div class="form-col">
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
		    <div class="form-col preview-container">
		      <label for="image_file" class="form-label">이미지 파일</label>
		      <input type="file" class="form-control" name="image_file" id="image_file" accept="image/*" onchange="previewLocalImage(this);">
		      <div class="form-text">현재 이미지: <%= cosmetic.getImage_file() %></div>
		    </div>
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

<section class="white-space"></section>

<%@ include file="footer.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
