<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>    
<meta charset="UTF-8">
<title>지역추가</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
<link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/CrudLocation_style.css">
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
      <form id="cityForm" method="post" action="process_AddLocation.jsp" class="grid-form">
        <input type="hidden" name="table" value="city">
        <div class="form-left-side">
          <div class="form-row-custom">
            <div class="form-col">
              <label for="city_num">도시 번호</label>
              <input type="text" class="form-control" name="city_num" required>
            </div>
            <div class="form-col">
              <label for="title">도시 이름</label>
              <input type="text" class="form-control" name="title" required>
            </div>
          </div>
          <div class="form-col">
            <label for="note">도시 설명</label>
            <input type="text" class="form-control" name="note" required>
          </div>
          <div class="form-row-custom">
            <div class="form-col">
              <label for="tag1">태그 1</label>
              <input type="text" class="form-control" name="tag1">
            </div>
            <div class="form-col">
              <label for="tag2">태그 2</label>
              <input type="text" class="form-control" name="tag2">
            </div>
          </div>
          <div class="form-row-custom">
            <div class="form-col">
              <label for="tag3">태그 3</label>
              <input type="text" class="form-control" name="tag3">
            </div>
            <div class="form-col">
              <label for="image_file">이미지 파일</label>
              <input type="file" class="form-control" id="image_file" accept="image/*">
              <input type="hidden" name="img" id="city_hidden_img">
            </div>
          </div>
        </div>
        <div class="preview-container">
          <div>
            <img id="imagePreview" src="<%= request.getContextPath() %>/resources/img/no_image.jpg" alt="미리보기" style="display: block;">
          </div>
        </div>
        <div class="text-end">
          <button type="submit" class="btn btn-primary">등록</button>
        </div>
      </form>

      <!-- DISTRICT FORM -->
      <form id="districtForm" method="post" action="process_AddLocation.jsp" class="grid-form" style="display: none;">
        <input type="hidden" name="table" value="city_district">
        <div class="form-left-side">
          <div class="form-row-custom">
            <div class="form-col">
              <label for="d_city_num">도시 번호</label>
              <input type="text" class="form-control" name="d_city_num" required>
            </div>
            <div class="form-col">
              <label for="d_title">명소 이름</label>
              <input type="text" class="form-control" name="d_title" required>
            </div>
          </div>
          <div class="form-col">
            <label for="d_note">설명</label>
            <input type="text" class="form-control" name="d_note" required>
          </div>
          <div class="form-row-custom">
            <div class="form-col">
              <label for="d_tag1">태그 1</label>
              <input type="text" class="form-control" name="d_tag1">
            </div>
            <div class="form-col">
              <label for="d_tag2">태그 2</label>
              <input type="text" class="form-control" name="d_tag2">
            </div>
          </div>
          <div class="form-row-custom">
            <div class="form-col">
              <label for="d_tag3">태그 3</label>
              <input type="text" class="form-control" name="d_tag3">
            </div>
            <div class="form-col">
              <label for="district_img_file">메인 이미지</label>
              <input type="file" class="form-control" id="district_img_file" accept="image/*">
              <input type="hidden" name="d_img" id="district_main_img">
            </div>
          </div>
          <div class="form-row-custom">
            <div class="form-col">
              <label for="tag1_img_file">태그1 이미지</label>
              <input type="file" class="form-control" id="tag1_img_file" accept="image/*">
              <input type="hidden" name="d_tag1_img" id="tag1_img">
            </div>
            <div class="form-col">
              <label for="tag2_img_file">태그2 이미지</label>
              <input type="file" class="form-control" id="tag2_img_file" accept="image/*">
              <input type="hidden" name="d_tag2_img" id="tag2_img">
            </div>
          </div>
          <div class="form-row-custom">
            <div class="form-col">
              <label for="tag3_img_file">태그3 이미지</label>
              <input type="file" class="form-control" id="tag3_img_file" accept="image/*">
              <input type="hidden" name="d_tag3_img" id="tag3_img">
            </div>
            <div class="form-col"></div>
          </div>
        </div>

        <div class="preview-container">
    <div id="imagePreviewContainer">
    <img id="district_main_preview" src="<%= request.getContextPath() %>/resources/img/no_image.jpg" alt="미리보기"
         style="max-width: 100%; max-height: 100%; object-fit: contain; display: block;" />
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
function toggleForm() {
  const selected = document.getElementById("tableSelect").value;
  document.getElementById("cityForm").style.display = selected === "city" ? "grid" : "none";
  document.getElementById("districtForm").style.display = selected === "city_district" ? "grid" : "none";
}

async function uploadImage(file, previewId, hiddenInputId) {
  const formData = new FormData();
  formData.append("upload", file); // 반드시 upload라는 이름 사용

  try {
    const res = await fetch("uploadImage", {
      method: "POST",
      body: formData
    });

    if (!res.ok) {
      alert("이미지 업로드 실패");
      return;
    }

    const imageUrl = await res.text();
    console.log("이미지 업로드 응답:", imageUrl);  // 디버깅용 로그

    // 응답 검증
    if (imageUrl.includes("<html") || imageUrl.length > 255) {
      alert("이미지 경로 처리 실패");
      return;
    }

    // 절대경로 조립 (파일명만 DB에 저장할 때)
    const fullUrl = window.location.origin + "<%= request.getContextPath() %>/resources/img/" + imageUrl;

    if (previewId) document.getElementById(previewId).src = fullUrl;
    if (hiddenInputId) document.getElementById(hiddenInputId).value = imageUrl;

  } catch (err) {
    console.error("업로드 중 오류:", err);
    alert("이미지 업로드 중 문제가 발생했습니다.");
  }
}

window.onload = () => {
  toggleForm();

  document.getElementById("image_file").addEventListener("change", function () {
    if (this.files[0]) uploadImage(this.files[0], "imagePreview", "city_hidden_img");
  });

  document.getElementById("district_img_file").addEventListener("change", function () {
    if (this.files[0]) uploadImage(this.files[0], "district_main_preview", "district_main_img");
  });

  document.getElementById("tag1_img_file").addEventListener("change", function () {
    if (this.files[0]) uploadImage(this.files[0], "preview_tag1", "tag1_img");
  });

  document.getElementById("tag2_img_file").addEventListener("change", function () {
    if (this.files[0]) uploadImage(this.files[0], "preview_tag2", "tag2_img");
  });

  document.getElementById("tag3_img_file").addEventListener("change", function () {
    if (this.files[0]) uploadImage(this.files[0], "preview_tag3", "tag3_img");
  });
};
</script>





</body>
</html>
