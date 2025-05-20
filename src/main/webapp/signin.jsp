<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<script src="./resources/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="./resources/css/index_style.css">
<link href="./resources/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="./resources/css/signin.css">
<link rel="stylesheet" href="./resources/css/footer.css">

<script>
   function showModal(message) {
     const modal = new bootstrap.Modal(document.getElementById('formAlertModal'));
     document.getElementById('formAlertMessage').textContent = message;
     modal.show();
   }

   function checkForm() {
      const form = document.newMember;
      if (!form.id.value) {
         showModal("아이디를 입력하세요.");
         return false;
      }

      if (!form.password.value) {
         showModal("비밀번호를 입력하세요.");
         return false;
      }

      if (form.password.value !== form.password_confirm.value) {
         showModal("비밀번호를 동일하게 입력하세요.");
         return false;
      }

      return true;
   }
</script>
</head>
<style>
.btn:hover {
	color: white !important;
}
</style>
<body>
	<%@ include file="header.jsp"%>
	<section class="hero" style="padding-top: 100px; margin-bottom: 100px;">
		<div class="container">
			<div class="row align-items-md-stretch text-center">
				<h2 class="mt-3 mb-4">회원가입</h2>
				<form name="newMember" action="processSignin.jsp" method="post"
					onsubmit="return checkForm()" class="member">
					<div class="mb-3 row">
						<label class="col-sm-2 ">아이디</label>
						<div class="col-sm-3">
							<input id="id" name="id" type="text" class="form-control"
								placeholder="id">
						</div>
					</div>
					<div class="mb-3 row">
						<label class="col-sm-2">비밀번호</label>
						<div class="col-sm-3">
							<input name="password" type="password" class="form-control"
								placeholder="password">
						</div>
					</div>
					<div class="mb-3 row">
						<label class="col-sm-2">비밀번호확인</label>
						<div class="col-sm-3">
							<input name="password_confirm" type="password"
								class="form-control" placeholder="password confirm">
						</div>
					</div>
					<div class="mb-3 row">
						<label class="col-sm-2">성명</label>
						<div class="col-sm-3">
							<input name="name" type="text" class="form-control"
								placeholder="name">
						</div>
					</div>
					<div class="mb-3 row">
						<label class="col-sm-2">성별</label>
						<div class="col-sm-2 custom-gender-padding">
							<input name="gender" type="radio" value="남" /> 남 <input
								name="gender" type="radio" value="여" /> 여
						</div>
					</div>

					<div class="mb-3 row">
						<label class="col-sm-2" style="padding-top: 15px;">생일</label>
						<div class="col-sm-10  ">
							<div class="row">
								<div class="col-sm-2">
									<input type="text" name="birthyy" maxlength="4"
										class="form-control" placeholder="년(4자)" size="6">
								</div>
								<div class="col-sm-2">
									<select name="birthmm" class="form-select">
										<option value="">월</option>
										<option value="01">1</option>
										<option value="02">2</option>
										<option value="03">3</option>
										<option value="04">4</option>
										<option value="05">5</option>
										<option value="06">6</option>
										<option value="07">7</option>
										<option value="08">8</option>
										<option value="09">9</option>
										<option value="10">10</option>
										<option value="11">11</option>
										<option value="12">12</option>
									</select>
								</div>
								<div class="col-sm-2">
									<input type="text" name="birthdd" maxlength="2"
										class="form-control" placeholder="일" size="4">
								</div>
							</div>
						</div>
					</div>

					<div class="mb-3 row">
						<label class="col-sm-2">이메일</label>
						<div class="col-sm-10">
							<div class="row">
								<div class="col-sm-4">
									<input type="text" name="email1" maxlength="50"
										class="form-control" placeholder="email">
								</div>
								@
								<div class="col-sm-3">
									<select name="email2" class="form-select">
										<option>naver.com</option>
										<option>daum.net</option>
										<option>gmail.com</option>
										<option>nate.com</option>
									</select>
								</div>
							</div>
						</div>
					</div>
					<div class="mb-3 row">
						<label class="col-sm-2">전화번호</label>
						<div class="col-sm-3">
							<input name="phone" type="text" class="form-control"
								placeholder="010-0000-0000">
						</div>
					</div>
					<div class="mb-3 row">
						<label class="col-sm-2 ">주소</label>
						<div class="col-sm-5">
							<input name="address" type="text" class="form-control"
								placeholder="address">
						</div>
					</div>
					<div class="mb-3 row">
						<div class="col-sm-offset-2 col-sm-10 ">
							<input type="submit" class="btn" value="등록 ">
							<input type="reset" class="btn cancle" value="취소 "
								onclick="reset()">
						</div>
					</div>
				</form>
			</div>
		</div>
	</section>
	<!-- 부트스트랩 경고 모달 -->
	<div class="modal fade" id="formAlertModal" tabindex="-1" aria-labelledby="formAlertModalLabel" aria-hidden="true">
	  	<div class="modal-dialog">
		    <div class="modal-content">
		      	<div class="modal-header">
			        <h5 class="modal-title" id="formAlertModalLabel">입력 오류</h5>
			        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="닫기"></button>
		      	</div>
		      	<div class="modal-body" id="formAlertMessage">
		        	<!-- JavaScript로 오류 메시지가 여기에 표시됩니다 -->
		      	</div>
		      	<div class="modal-footer border-0">
		        	<button type="button" class="btn" data-bs-dismiss="modal">확인</button>
		      	</div>
	    	</div>
	  	</div>
	</div>
	<footer>
		<div class="copyright">
			<p>&copy; 2025 K-FOOD GUIDE. All rights reserved.</p>
		</div>
	</footer>
</body>
</html>