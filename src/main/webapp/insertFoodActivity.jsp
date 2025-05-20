<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>체험 활동 등록</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
	<link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/CrudCosmetics_style.css">
	<script src="<%= request.getContextPath() %>/resources/js/imagePreview.js"></script>
    <style>
	#imagePreview {
	  width: 100%;
	  height: 100%;
	  object-fit: contain;
	  display: block;
	}
	#imagePreviewContainer {
		border: none;
	}
    </style>
</head>
<body>
<%@ include file="header.jsp" %>

<section class="white-space"></section>

<section class="bg-image">
	<div class=" overlay">
		<div class="container pt-5 pb-5">
		    <h3 class="mb-4 text-start">체험 활동 등록</h3>
		    <form action="processInsertFoodActivity.jsp" method="post" enctype="multipart/form-data" class="needs-validation" novalidate>
				<div class="form-left-side">
					<div class="form-row-custom">
				        <div class="form-col">
				            <label for="TITLE" class="form-label">제목</label>
				            <input type="text" name="TITLE" id="TITLE" class="form-control" required>
				        </div>
   				        <div class="form-col">
				            <label for="MAX_COUNT" class="form-label">정원</label>
				            <input type="number" name="MAX_COUNT" id="MAX_COUNT" class="form-control" required>
				        </div>    
			        </div>
			
					<div class="form-row-custom">
				        <div class="form-col">
				            <label for="ACT_DATE" class="form-label">체험일자</label>
				            <input type="text" name="ACT_DATE" id="ACT_DATE" class="form-control" required>
				        </div>
				        <div class="form-col">
				            <label for="ADDRESS" class="form-label">주소</label>
				            <input type="text" name="ADDRESS" id="ADDRESS" class="form-control" required>
				        </div>
			        </div>
			
					<div class="form-row-custom">
					</div>
					<div class="form-row-custom">
				        <div class="form-col">
				            <label for="NOTE" class="form-label">설명</label>
				            <textarea name="NOTE" id="NOTE" class="form-control" rows="4"></textarea>
				        </div>
			        </div>
			        
	  	          	<div class="form-row-custom">
		            	<div class="form-col">
			              	<label for="image_file" class="form-label">이미지 파일</label>
			              	<input type="file" class="form-control" name="image_file_upload" id="image_file" accept="image/*" onchange="previewLocalImage(this);">
		            	</div>
		            	<div class="form-col"></div>
		          	</div>
        		</div> 

       	        <!-- 오른쪽 미리보기 박스 -->
		        <div class="preview-container">
		          <div id="imagePreviewContainer">
		            <img id="imagePreview" src="<%= request.getContextPath() %>/resources/img/no_image.jpg" alt="미리보기">
		          </div>
		        </div>
		
		        <div class="text-end">
		            <button type="submit" class="btn btn-primary">등록</button>
		            <a href="adminPage.jsp" class="btn btn-danger">취소</a>
		        </div>
		    </form>
		</div>
	</div>
</section>

<section class="white-space"></section>

<%@ include file="footer.jsp" %>

</body>
</html>
