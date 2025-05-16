<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>    
<meta charset="UTF-8">
<title>공간 추가</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
<link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/CrudLocation_style.css">
<script src="<%= request.getContextPath() %>/resources/js/imagePreview.js"></script>
<script src="<%= request.getContextPath() %>/resources/js/previewMultiImages.js"></script>
</head>
<body>
<%@ include file="header.jsp" %>

<section class="white-space"></section>

<section class="bg-image">
  <div class="overlay">
    <div class="container pt-5 pb-5">
      <div class="d-flex justify-content-between align-items-center mb-4">
        <h3 class="mb-0">지역 등록</h3>
        <select id="tableSelect" class="form-select w-auto" onchange="toggleForm()">
          <option value="city">city</option>
          <option value="city_district">city_district</option>
        </select>
      </div>

      <!-- CITY FORM -->
      <form id="cityForm" method="post" action="process_AddLocation.jsp" enctype="multipart/form-data" class="grid-form">
        <div class="form-left-side">
          <!-- form 내용 동일 -->
          <div class="form-row-custom">
            <div class="form-col">
              <label for="city_num">도시 ID</label>
              <input type="number" class="form-control" name="city_num" id="city_num" required>
            </div>
            <div class="form-col">
              <label for="city_title">도시 이름</label>
              <input type="text" class="form-control" name="city_title" id="city_title" required>
            </div>
          </div>
          <div class="form-col">
            <label for="city_note">도시 설명</label>
            <input type="text" class="form-control" name="city_note" id="city_note">
          </div>
          <div class="form-row-custom">
            <div class="form-col">
              <label for="city_tag1">태그 1</label>
              <input type="text" class="form-control" name="city_tag1" id="city_tag1">
            </div>
            <div class="form-col">
              <label for="city_tag2">태그 2</label>
              <input type="text" class="form-control" name="city_tag2" id="city_tag2">
            </div>
          </div>
          <div class="form-row-custom">
            <div class="form-col">
              <label for="city_tag3">태그 3</label>
              <input type="text" class="form-control" name="city_tag3" id="city_tag3">
            </div>
            <div class="form-col">
              <label for="image_file">이미지 파일</label>
              <input type="file" class="form-control" name="image_file" id="image_file" accept="image/*" onchange="previewLocalImage(this);" required>
            </div>
          </div>
        </div>
        <div class="preview-container">
          <div id="imagePreviewContainer">
            <img id="imagePreview" src="<%= request.getContextPath() %>/resources/img/no_image.jpg" alt="미리보기" style="display: block;">
          </div>
        </div>
        <div class="text-end">
          <button type="submit" class="btn btn-primary">등록</button>
        </div>
      </form>

      <!-- DISTRICT FORM -->
      <form id="districtForm" method="post" action="process_AddLocation.jsp" enctype="multipart/form-data" class="grid-form" style="display: none;">
        <div class="form-left-side">
          <div class="form-row-custom">
            <div class="form-col">
              <label for="district_city_num">도시 ID</label>
              <input type="number" class="form-control" name="district_city_num" id="district_city_num" required>
            </div>
            <div class="form-col">
              <label for="district_title">명소 이름</label>
              <input type="text" class="form-control" name="district_title" id="district_title" required>
            </div>
          </div>
          <div class="form-col">
            <label for="district_note">설명</label>
            <input type="text" class="form-control" name="district_note" id="district_note" required>
          </div>
          <div class="form-row-custom">
            <div class="form-col">
              <label for="district_tag1">태그 1</label>
              <input type="text" class="form-control" name="district_tag1" id="district_tag1">
            </div>
            <div class="form-col">
              <label for="district_tag2">태그 2</label>
              <input type="text" class="form-control" name="district_tag2" id="district_tag2">
            </div>
          </div>
          <div class="form-row-custom">
            <div class="form-col">
              <label for="district_tag3">태그 3</label>
              <input type="text" class="form-control" name="district_tag3" id="district_tag3">
            </div>
            <div class="form-col">
              <label for="img_file">메인 이미지</label>
              <input type="file" class="form-control" name="img_file" id="district_img_file" accept="image/*" onchange="previewLocalImage(this)">
            </div>
          </div>
          <div class="form-row-custom">
            <div class="form-col">
              <label for="tag1_img_file">태그1 이미지</label>
              <input type="file" class="form-control" name="tag1_img_file" onchange="previewLocalImageTo('preview_tag1', this)">
            </div>
            <div class="form-col">
              <label for="tag2_img_file">태그2 이미지</label>
              <input type="file" class="form-control" name="tag2_img_file" onchange="previewLocalImageTo('preview_tag2', this)">
            </div>
          </div>
          <div class="form-row-custom">
            <div class="form-col">
              <label for="tag3_img_file">태그3 이미지</label>
              <input type="file" class="form-control" name="tag3_img_file" onchange="previewLocalImageTo('preview_tag3', this)">
            </div>
            <div class="form-col"></div>
          </div>
        </div>
        <div class="preview-container">
          <div id="imagePreviewContainer">
            <img id="imagePreview" src="<%= request.getContextPath() %>/resources/img/no_image.jpg" alt="미리보기" style="display: block;">
          </div>
        </div>
        <div class="tag-preview-row mt-4">
          <div class="tag-preview-box"><img id="preview_tag1" src="<%= request.getContextPath() %>/resources/img/no_image.jpg" /></div>
          <div class="tag-preview-box"><img id="preview_tag2" src="<%= request.getContextPath() %>/resources/img/no_image.jpg" /></div>
          <div class="tag-preview-box"><img id="preview_tag3" src="<%= request.getContextPath() %>/resources/img/no_image.jpg" /></div>
        </div>
        <div class="text-end mt-4">
          <button type="submit" class="btn btn-primary">등록</button>
        </div>
      </form>
    </div>
  </div>
</section>

<section class="white-space"></section>
<%@ include file="footer.jsp" %>

<script>
function updateHiddenInput() {
  const selected = document.getElementById("tableSelect").value;
  const cityForm = document.getElementById("cityForm");
  const districtForm = document.getElementById("districtForm");

  cityForm.style.display = selected === "city" ? "grid" : "none";
  districtForm.style.display = selected === "city_district" ? "grid" : "none";
}

function handleFormSubmit(e) {
  e.preventDefault(); // 기본 제출 막고

  const selected = document.getElementById("tableSelect").value;
  const form = selected === "city"
    ? document.getElementById("cityForm")
    : document.getElementById("districtForm");

  // 기존 hidden 제거 후 다시 추가
  const old = form.querySelector("input[name='table']");
  if (old) old.remove();

  const input = document.createElement("input");
  input.type = "hidden";
  input.name = "table";
  input.value = selected;
  form.appendChild(input);

  console.log("▶ hidden input 삽입 완료:", input.value);

  form.submit(); // 수동으로 form 제출
}

window.onload = () => {
  updateHiddenInput();

  document.getElementById("tableSelect").addEventListener("change", updateHiddenInput);
  document.getElementById("cityForm").addEventListener("submit", handleFormSubmit);
  document.getElementById("districtForm").addEventListener("submit", handleFormSubmit);
};
</script>



<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
