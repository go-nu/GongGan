<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
String id = request.getParameter("id");
if (id == null || id.trim().equals("")) {
    id = "admin";
}
%>
<%
    String category = request.getParameter("category");
    if (category == null || category.trim().isEmpty()) {
        category = "food"; // 기본값
    }
%>
<script type="text/javascript"
	src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpKeyId=14z98e6lun"></script>
<html>
<head>
<link rel="stylesheet" href="./resources/css/styles.css">
<link rel="stylesheet" href="./resources/css/bootstrap.min.css" />

<script type="text/javascript">
function showModal(message) {
	const modal = new bootstrap.Modal(document.getElementById("alertModal"));
	document.getElementById("alertMessage").textContent = message;
	modal.show();
}

function checkForm() {
	const form = document.newWrite;

	if (!form.subject.value.trim()) {
		showModal("제목을 입력하세요.");
		return false;
	}
	if (!form.content.value.trim()) {
		showModal("내용을 입력하세요.");
		return false;
	}
	if (!document.querySelector('input[name="category"]:checked')) {
		showModal("카테고리를 선택하세요.");
		return false;
	}
	return true;
}
</script>
<title>Board</title>
<style>
#map {
	width: 100%;
	height: 400px;
	margin-top: 20px;
	border: 1px solid #ccc;
}
</style>
</head>

<body>
	<jsp:include page="../header.jsp" />

	<div class="main-container">
		<div class="content-wrap board-write py-5" style="margin-top: 80px;">
			<div class="container">
				<h2 class="mb-4">📝 글쓰기</h2>

				<form name="newWrite" action="./BoardWriteAction.do" method="post"
					enctype="multipart/form-data" onsubmit="return checkForm()">
					<!-- 서버에 전달할 사용자 ID (숨김) -->
					<input type="hidden" name="id" value="<%= id %>">
					<input type="hidden" name="category" value="<%=category%>">
					
					<!-- 사용자에게 보여줄 ID -->
					<div class="mb-3 row">
					    <label class="col-sm-2 col-form-label"><strong>작성자</strong></label>
					    <div class="col-sm-4">
					        <input type="text" class="form-control" value="<%= id %>" readonly>
					    </div>
					</div>
					
					<!-- ✅ 카테고리 선택 -->
					<!-- <div class="mb-3">
					    <label class="col-sm-2 col-form-label"><strong>카테고리 선택</strong></label>
					    <div class="form-check form-check-inline">
					        <input class="form-check-input" type="radio" name="category" id="categoryFood" value="food" checked>
					        <label class="form-check-label" for="categoryFood">K-Food</label>
					    </div>
					    <div class="form-check form-check-inline">
					        <input class="form-check-input" type="radio" name="category" id="categoryBeauty" value="beauty">
					        <label class="form-check-label" for="categoryBeauty">K-Beauty</label>
					    </div>
					    <div class="form-check form-check-inline">
					        <input class="form-check-input" type="radio" name="category" id="categoryLocation" value="location">
					        <label class="form-check-label" for="categoryLocation">K-Location</label>
					    </div>
					</div> -->
					

					<div class="mb-3 row">
						<label class="col-sm-2 col-form-label"><strong>제목</strong></label>
						<div class="col-sm-6">
							<input name="subject" type="text" class="form-control"
								placeholder="제목을 입력하세요." required>
						</div>
					</div>

					<div class="mb-3 row">
						<label class="col-sm-2 col-form-label"><strong>내용</strong></label>
						<div class="col-sm-8">
							<textarea name="content" rows="6" class="form-control"
								placeholder="내용을 입력하세요." required></textarea>
						</div>
					</div>

					<!-- 첨부파일 필드 추가 -->
					<div class="mb-3 row">
						<label class="col-sm-2 col-form-label"><strong>첨부파일</strong></label>
						<div class="col-sm-8">
							<input type="file" name="attachment" class="form-control">
							<small class="form-text text-muted">파일 크기는 최대 10MB까지
								가능합니다.</small>
						</div>
					</div>


					<div class="mb-3 row">
						<div class="offset-sm-2 col-sm-10">
							<input type="submit" class="btn btn-primary me-2" value="등록">
							<a href="BoardListAction.do" class="btn btn-secondary">취소</a>
							<!-- 목록 버튼 추가 (카테고리 전달 포함) 250519 -->
							<a href="BoardListAction.do?category=${param.category}" class="btn btn-success">목록</a>
						</div>
					</div>
					
				</form>
			</div>
		</div>
	</div>
	<!-- 부트스트랩 모달 -->
	<div class="modal fade" id="alertModal" tabindex="-1" aria-labelledby="alertModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="alertModalLabel">입력 오류</h5>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="닫기"></button>
	      </div>
	      <div class="modal-body" id="alertMessage">
	        <!-- 메시지가 여기에 삽입됩니다 -->
	      </div>
	      <div class="modal-footer border-0">
	        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">확인</button>
	      </div>
	    </div>
	  </div>
	</div>

	<jsp:include page="../footer.jsp" />
</body>


</html>

