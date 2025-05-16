<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ include file="dbconn.jsp" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>지역 수정/삭제</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/CrudLocation_style.css">
  <style>
    .btn-group-bottom {
      display: flex;
      justify-content: flex-end;
      gap: 10px;
      margin-top: 30px;
    }
    .btn-group-bottom form,
    .btn-group-bottom button {
      margin: 0;
      padding: 0;
    }
    .btn-group-bottom .btn {
      min-width: 120px;
      height: 40px;
      align-self: center;
    }
    .btn-group-bottom form {
      display: flex;
      align-items: center;
    }
  </style>
</head>
<body>
<%@ include file="header.jsp" %>
<section class="white-space"></section>
<section class="bg-image">
  <div class="overlay">
    <div class="container pt-5 pb-5">
      <div class="d-flex justify-content-between align-items-center mb-4">
        <h3 class="mb-0">지역 수정 / 삭제</h3>
        <form method="get" action="" class="d-flex flex-nowrap gap-2 align-items-center">
          <select name="table" class="form-select" style="min-width: 160px;">
            <option value="city" <%= "city".equals(request.getParameter("table")) ? "selected" : "" %>>city</option>
            <option value="city_district" <%= "city_district".equals(request.getParameter("table")) ? "selected" : "" %>>city_district</option>
          </select>
          <input type="number" name="id" class="form-control" placeholder="ID" value="<%= request.getParameter("id") != null ? request.getParameter("id") : "" %>" style="max-width: 160px;">
          <button type="submit" class="btn btn-outline-primary" style="white-space: nowrap;">조회</button>
        </form>
      </div>

<%
String table = request.getParameter("table");
String id = request.getParameter("id");
String title = "";
String note = "";
String tag1 = "";
String tag2 = "";
String tag3 = "";
String img = "no_image.jpg";
String tag1_img = "no_image.jpg";
String tag2_img = "no_image.jpg";
String tag3_img = "no_image.jpg";

if (table != null && id != null) {
  PreparedStatement pstmt = null;
  ResultSet rs = null;
  try {
    String sql = "SELECT * FROM " + table + " WHERE " + ("city".equals(table) ? "city_num" : "id") + " = ?";
    pstmt = conn.prepareStatement(sql);
    pstmt.setInt(1, Integer.parseInt(id));
    rs = pstmt.executeQuery();
    if (rs.next()) {
      if ("city".equals(table)) {
        title = rs.getString("title");
        note = rs.getString("note");
        tag1 = rs.getString("tag1");
        tag2 = rs.getString("tag2");
        tag3 = rs.getString("tag3");
        img = rs.getString("img");
      } else {
        title = rs.getString("d_title");
        note = rs.getString("d_note");
        tag1 = rs.getString("d_tag1");
        tag2 = rs.getString("d_tag2");
        tag3 = rs.getString("d_tag3");
        img = rs.getString("d_img");
        tag1_img = rs.getString("d_tag1_img");
        tag2_img = rs.getString("d_tag2_img");
        tag3_img = rs.getString("d_tag3_img");
      }
    }
  } catch (Exception e) {
    out.println("<div class='alert alert-danger'>오류: " + e.getMessage() + "</div>");
  } finally {
    if (rs != null) rs.close();
    if (pstmt != null) pstmt.close();
  }
}
%>

      <!-- 수정 폼 시작 -->
      <form method="post" action="process_UpdateLocation.jsp" enctype="multipart/form-data" class="grid-form">
        <input type="hidden" name="table" value="<%= table != null ? table : "city" %>">
        <input type="hidden" name="id" value="<%= id != null ? id : "" %>">

        <div class="form-left-side">
          <div class="form-row-custom">
            <div class="form-col">
              <label>ID</label>
              <input type="number" class="form-control" name="num" value="<%= id != null ? id : "" %>">
            </div>
            <div class="form-col">
              <label>이름</label>
              <input type="text" class="form-control" name="title" value="<%= title %>">
            </div>
          </div>
          <div class="form-col">
            <label>설명</label>
            <input type="text" class="form-control" name="note" value="<%= note %>">
          </div>
          <div class="form-row-custom">
            <div class="form-col">
              <label>태그 1</label>
              <input type="text" class="form-control" name="tag1" value="<%= tag1 %>">
            </div>
            <div class="form-col">
              <label>태그 2</label>
              <input type="text" class="form-control" name="tag2" value="<%= tag2 %>">
            </div>
          </div>
          <div class="form-row-custom">
            <div class="form-col">
              <label>태그 3</label>
              <input type="text" class="form-control" name="tag3" value="<%= tag3 %>">
            </div>
            <div class="form-col">
              <label>이미지 파일</label>
              <input type="file" class="form-control" name="image_file">
            </div>
          </div>
        </div>

        <div class="preview-container">
          <div id="imagePreviewContainer">
            <img id="imagePreview" src="<%= request.getContextPath() %>/resources/img/<%= img %>" alt="미리보기" style="display: block;">
          </div>
        </div>

        <% if ("city_district".equals(table)) { %>
        <div class="tag-preview-row mt-4">
          <div class="tag-preview-box"><img id="preview_tag1" src="<%= request.getContextPath() %>/resources/img/<%= tag1_img %>" /></div>
          <div class="tag-preview-box"><img id="preview_tag2" src="<%= request.getContextPath() %>/resources/img/<%= tag2_img %>" /></div>
          <div class="tag-preview-box"><img id="preview_tag3" src="<%= request.getContextPath() %>/resources/img/<%= tag3_img %>" /></div>
        </div>
        <% } %>
        
			<!-- 버튼 영역: 항상 오른쪽 아래로 고정 -->
			<div class="btn-group-bottom mt-4">
			  <!-- 수정 form -->
			  <form method="post" action="process_UpdateLocation.jsp" enctype="multipart/form-data">
			    <input type="hidden" name="table" value="<%= table != null ? table : "city" %>">
			    <input type="hidden" name="id" value="<%= id != null ? id : "" %>">
			    <button type="submit" class="btn btn-success">수정</button>
			  </form>
			
			  <!-- 삭제 form -->
			  <form method="post" action="process_DeleteLocation.jsp" onsubmit="return confirm('정말 삭제하시겠습니까?');">
			    <input type="hidden" name="table" value="<%= table %>">
			    <input type="hidden" name="id" value="<%= id != null ? id : "" %>">
			    <button type="submit" class="btn btn-danger">삭제</button>
			  </form>
			</div>
    	   </div>
  </div>
</section>
<section class="white-space"></section>
<%@ include file="footer.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
