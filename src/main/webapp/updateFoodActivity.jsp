<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ include file="dbconn.jsp" %>
<%
    String actId = request.getParameter("ACT_ID");
    String sql = "SELECT * FROM fs_semi.activity WHERE ACT_ID = ?";
    PreparedStatement pstmt = conn.prepareStatement(sql);
    pstmt.setString(1, actId);
    ResultSet rs = pstmt.executeQuery();

    if (!rs.next()) {
        out.println("<script>alert('해당 체험 활동이 존재하지 않습니다.'); history.back();</script>");
        return;
    }

    String imgFile = rs.getString("IMG");
%>
<!DOCTYPE html>
<html>
<head>
    <title>체험 활동 수정</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
	<link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/CrudCosmetics_style.css">
	<script src="<%= request.getContextPath() %>/resources/js/imagePreview.js"></script>
</head>
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
<body>
<%@ include file="header.jsp" %>
<%
String returnURL = request.getParameter("returnURL");
%>
<section class="white-space"></section>

<section class="bg-image">
	<div class=" overlay">
		<div class="container pt-5 pb-5">
		    <h3 class="mb-4 text-start">체험 활동 수정</h3>
		    <form action="processUpdateFoodActivity.jsp" method="post" enctype="multipart/form-data" class="needs-validation" novalidate>
		        <input type="hidden" name="ACT_ID" value="<%= actId %>">
		        <input type="hidden" name="oldImg" value="<%= imgFile %>">
		        <input type="hidden" name="returnURL" value="<%= returnURL %>">
		
				<div class="form-left-side">
					<div class="form-row-custom">
				        <div class="form-col">
				            <label for="TITLE" class="form-label">제목</label>
				            <input type="text" name="TITLE" id="TITLE" class="form-control" value="<%= rs.getString("TITLE") %>" required>
				        </div>
				
				        <div class="form-col">
				            <label for="PRICE" class="form-label">가격</label>
				            <input type="number" name="PRICE" id="PRICE" class="form-control" value="<%= rs.getInt("PRICE") %>" required>
				        </div>
			        </div>
			
					<div class="form-row-custom">
				        <div class="form-col">
				            <label for="MAX_COUNT" class="form-label">정원</label>
				            <input type="number" name="MAX_COUNT" id="MAX_COUNT" class="form-control" value="<%= rs.getInt("MAX_COUNT") %>" required>
				        </div>
				
				        <div class="form-col">
				            <label for="ACT_DATE" class="form-label">체험일자</label>
				            <input type="text" name="ACT_DATE" id="ACT_DATE" class="form-control" value="<%= rs.getString("ACT_DATE") %>" required>
				        </div>
			        </div>
			
					<div class="form-row-custom">
				        <div class="form-col">
				            <label for="ADDRESS" class="form-label">주소</label>
				            <input type="text" name="ADDRESS" id="ADDRESS" class="form-control" value="<%= rs.getString("ADDRESS") %>" required>
				        </div>
					</div>
					<div class="form-row-custom">
				        <div class="form-col">
				            <label for="NOTE" class="form-label">설명</label>
				            <textarea name="NOTE" id="NOTE" class="form-control" rows="4"><%= rs.getString("NOTE") %></textarea>
				        </div>
			        </div>
			        
	  	          	<div class="form-row-custom">
		            	<div class="form-col">
			              	<label for="image_file" class="form-label">새 이미지(선택)</label>
			              	<input type="file" class="form-control" name="image_file_upload" id="image_file" accept="image/*" onchange="previewLocalImage(this);">
		            	</div>
		            	<div class="form-col"></div>
		          	</div>
        		</div> 

       	        <!-- 오른쪽 미리보기 박스 -->
		        <div class="preview-container">
		          <div id="imagePreviewContainer">
		            <img id="imagePreview" src="<%= request.getContextPath() %>/resources/img/<%= imgFile %>" alt="미리보기">
		          </div>
		        </div>
		
		        <div class="text-end">
		            <button type="submit" class="btn btn-primary">수정 완료</button>
		            <a href="#" onclick="history.back(); return false;" class="btn btn-secondary">취소</a>
		        </div>
		    </form>
		</div>
	</div>
</section>

<section class="white-space"></section>

<%@ include file="footer.jsp" %>
</body>
</html>
<%
    rs.close();
    pstmt.close();
    conn.close();
%>
