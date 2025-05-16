<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*, java.util.*"%>
<%@ page errorPage="exceptionNoSlideId.jsp"%>
<%@ include file="dbconn.jsp"%>
<!-- DB 연결 코드 포함 -->

<!DOCTYPE html>
<html lang="ko">
<script>
	// 이미지 파일 업로드 시 미리보기 기능
	function previewImage(event, filename) {
		var files = event.target.files; // 여러 파일을 처리하려면 files 배열 사용
		var previewContainer = document.getElementById('preview-container-'
				+ filename); // 고유한 미리보기 컨테이너

		// 기존 미리보기 이미지 제거
		previewContainer.innerHTML = '';

		// 각 파일에 대해 미리보기 이미지 생성
		for (var i = 0; i < files.length; i++) {
			var file = files[i];
			var reader = new FileReader();

			reader.onload = function(e) {
				var previewImage = document.createElement('img');
				previewImage.src = e.target.result;
				previewImage.style.width = '70%'; // 스타일을 여기에 추가 가능
				previewContainer.appendChild(previewImage);
			};

			reader.readAsDataURL(file);
		}
	}
</script>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>슬라이드 정보 수정</title>
<script src="./resources/js/bootstrap.bundle.min.js"></script>
<link href="./resources/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="./resources/css/index_style.css">
<style>
.btn {
	background-color: #0d6efd !important;
}
.first_title{
	padding-top: 110px;
}
.about-section{
	padding-bottom: 0px !important;
}
</style>
</head>
<body>
<%@ include file="header.jsp"%>
	<div class="container pb-4 first_title">
		<h1>슬라이드 수정</h1>
	</div>
	<br>
	<br>
	<%
	String pageId = request.getParameter("id");
	// URL 파라미터로 받은 슬라이드 ID
	if (pageId == null || pageId.isEmpty()) {
		out.println("<p>잘못된 요청입니다.</p>");
		return;
	}
	/* 파일명만 골라내서 sql문에 추출하도록 변경 */
	String url = pageId.substring(pageId.lastIndexOf("/") + 1);

	// DB에서 슬라이드 정보 조회
	String sql1 = "SELECT * FROM main WHERE url = ?";
	PreparedStatement pstmt1 = conn.prepareStatement(sql1);
	pstmt1.setString(1, url); // FILENAME을 사용하여 해당 슬라이드 조회
	ResultSet rs1 = pstmt1.executeQuery();
	boolean firstItem = true; // 첫 번째 아이템을 구분하기 위해 사용
	int currentRow1 = 1; // 현재 행 번호 (1부터 시작)
	// 1부터 3번까지 반복
	%>
	<section>
		<div class="container">
			<%
			while (rs1.next() && currentRow1 <= 3) {
			%>

			<form action="processUpdatePage.jsp" method="post"
				enctype="multipart/form-data">
				<div class="container" style="display: flex;">
					<!-- 왼쪽: 슬라이드 이미지 -->
					<div class="image-container col-md-7">
						<h3>현재 슬라이드 <%=currentRow1%></h3>
						<img src="./resources/img/<%=rs1.getString("FILENAME")%>"
							id="current-image" alt="슬라이드 이미지" style="width: 70%;">
						<h3>변경할 슬라이드 <%=currentRow1%></h3>
						<div id="preview-container-<%=rs1.getString("FILENAME")%>">
							<!-- 미리보기 이미지가 여기 들어감 -->
						</div>
					</div>

					<!-- 오른쪽: 슬라이드 수정 폼 -->
					<div class="form-container col-md-5">
						<div class="mb-3 row">
							<label for="title" class="col-sm-2">슬라이드 제목</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" id="title" name="title"
									value="<%=rs1.getString("TITLE")%>" required>
							</div>
						</div>

						<div class="mb-3 row">
							<label for="note" class="col-sm-2">슬라이드 설명</label>
							<div class="col-sm-10">
								<textarea class="form-control" id="note" name="note" rows="3"
									required><%=rs1.getString("NOTE")%></textarea>
							</div>
						</div>

						<div class="mb-3 row">
							<label for="tag1" class="col-sm-2">태그 1</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" id="tag1" name="tag1"
									value="<%=rs1.getString("TAG1")%>">
							</div>
						</div>

						<div class="mb-3 row">
							<label for="tag2" class="col-sm-2">태그 2</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" id="tag2" name="tag2"
									value="<%=rs1.getString("TAG2")%>">
							</div>
						</div>

						<div class="mb-3 row">
							<label for="tag3" class="col-sm-2">태그 3</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" id="tag3" name="tag3"
									value="<%=rs1.getString("TAG3")%>">
							</div>
						</div>

						<div class="mb-3 row">
							<label for="tag4" class="col-sm-2">태그 4</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" id="tag4" name="tag4"
									value="<%=rs1.getString("TAG4")%>">
							</div>
						</div>

						<div class="mb-3 row">
							<label for="tag5" class="col-sm-2">태그 5</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" id="tag5" name="tag5"
									value="<%=rs1.getString("TAG5")%>">
							</div>
						</div>

						<div class="mb-3 row">
							<label for="filename" class="col-sm-2">이미지 파일</label>
							<div class="col-sm-10">
								<input type="file" class="form-control" id="newfilename"
									name="newfilename"
									onchange="previewImage(event, '<%=rs1.getString("FILENAME")%>')">
							</div>
						</div>

						<input type="hidden" name="filename"
							value="<%=rs1.getString("FILENAME")%>">
						<!-- 기존 FILENAME을 숨겨서 전송 -->

					</div>

				</div>
				<div class="container pb-4 pt-2">
					<button type="submit" class="btn btn-primary ms-auto d-block">수정
						완료</button>
				</div>
				<br>
				<br>
			</form>
			<%
			// 첫 번째 아이템이 처리된 후에는 "active" 클래스가 더 이상 추가되지 않도록 설정
			firstItem = false;
			currentRow1++; // 행 번호 증가
			}

			rs1.close();
			pstmt1.close();
			%>
		</div>
	</section>


	<section class="about-section">
	<div class="container pb-4 pt-2">
		<h1>카테고리 수정</h1>
	</div>
		<%
		// 카테고리 정보를 DB에서 조회
		String sql2 = "SELECT * FROM main"; // main 테이블에서 카테고리 정보를 가져옵니다
		Statement pstmt2 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY); // ResultSet 타입 설정
		ResultSet rs2 = pstmt2.executeQuery(sql2);
		rs2.absolute(3); // 두 번째 행으로 이동
		int currentRow2 = 1; // 현재 행 번호 (1부터 시작)
		// 카테고리 정보를 반복하여 출력
		while (rs2.next()) {
		%>
		<!-- <div class="container"> -->
		<form action="processUpdatePage.jsp" method="post"
			enctype="multipart/form-data">
			<div class="container" style="display: flex;">
				<!-- 왼쪽: 슬라이드 이미지 -->
				<div class="image-container col-md-7">
					<h3>현재 카테고리 <%=currentRow2%></h3>
					<img src="./resources/img/<%=rs2.getString("FILENAME")%>"
						id="current-image" alt="카테고리 이미지" style="width: 50%;">
					<h3>변경할 카테고리 <%=currentRow2%></h3>
					<div id="preview-container-<%=rs2.getString("FILENAME")%>">
						<!-- 미리보기 이미지가 여기 들어감 -->
					</div>
				</div>

				<!-- 오른쪽: 슬라이드 수정 폼 -->
				<div class="form-container col-md-5">
					<div class="mb-3 row">
						<label for="title" class="col-sm-2">카테고리 제목</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="title" name="title"
								value="<%=rs2.getString("TITLE")%>" required>
						</div>
					</div>

					<div class="mb-3 row">
						<label for="note" class="col-sm-2">카테고리 설명</label>
						<div class="col-sm-10">
							<textarea class="form-control" id="note" name="note" rows="3"
								required><%=rs2.getString("NOTE")%></textarea>
						</div>
					</div>

					<div class="mb-3 row">
						<label for="tag1" class="col-sm-2">태그 1</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="tag1" name="tag1"
								value="<%=rs2.getString("TAG1")%>">
						</div>
					</div>

					<div class="mb-3 row">
						<label for="tag2" class="col-sm-2">태그 2</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="tag2" name="tag2"
								value="<%=rs2.getString("TAG2")%>">
						</div>
					</div>

					<div class="mb-3 row">
						<label for="tag3" class="col-sm-2">태그 3</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="tag3" name="tag3"
								value="<%=rs2.getString("TAG3")%>">
						</div>
					</div>

					<div class="mb-3 row">
						<label for="tag4" class="col-sm-2">태그 4</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="tag4" name="tag4"
								value="<%=rs2.getString("TAG4")%>">
						</div>
					</div>

					<div class="mb-3 row">
						<label for="tag5" class="col-sm-2">태그 5</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="tag5" name="tag5"
								value="<%=rs2.getString("TAG5")%>">
						</div>
					</div>

					<div class="mb-3 row">
						<label for="filename" class="col-sm-2">이미지 파일</label>
						<div class="col-sm-10">
							<input type="file" class="form-control" id="newfilename"
								name="newfilename"
								onchange="previewImage(event, '<%=rs2.getString("FILENAME")%>')">
						</div>
					</div>

					<input type="hidden" name="filename"
						value="<%=rs2.getString("FILENAME")%>">
					<!-- 기존 FILENAME을 숨겨서 전송 -->

				</div>

			</div>
			<div class="container pb-4 pt-2">
				<button type="submit" class="btn btn-primary ms-auto d-block">수정
					완료</button>
			</div>
		</form>
		<%
		currentRow2++; // 행 번호 증가
		}

		rs2.close();
		pstmt2.close();
		%>
		<!-- </div> -->
	</section>
	<%@ include file="footer.jsp"%>
</body>
</html>
