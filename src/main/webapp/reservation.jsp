<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="mvc.model.BoardDTO"%>
<%@ page import = "java.util.*, java.text.*, java.sql.*" %>
<%@ include file="dbconn.jsp" %>
<%@ include file="header.jsp"%>
<%
    String sessionId = (String) session.getAttribute("id");
    String act_id = request.getParameter("act_id");

    PreparedStatement pstmt = null;
    ResultSet rs = null;
    boolean showSuccessModal = false;
    boolean showOverLimitModal = false;
    
    // 예약 요청 처리
    if ("POST".equalsIgnoreCase(request.getMethod()) && request.getParameter("name") != null) {
        String rsv_name = request.getParameter("name");
        int count = Integer.parseInt(request.getParameter("people"));
        String phone=request.getParameter("phone");

        if (conn == null) {
            out.println("<script>alert('DB 연결 실패'); history.back();</script>");
            return;
        }
        
        // 현재 예약 수와 최대 수 비교
        int totalReserved = 0;
        int maxCount = 0;

        String countSql = "SELECT IFNULL(SUM(count), 0) FROM reservation WHERE act_id = ?";
        pstmt = conn.prepareStatement(countSql);
        pstmt.setString(1, act_id);
        rs = pstmt.executeQuery();
        if (rs.next()) totalReserved = rs.getInt(1);
        rs.close(); pstmt.close();

        String maxSql = "SELECT max_count FROM activity WHERE act_id = ?";
        pstmt = conn.prepareStatement(maxSql);
        pstmt.setString(1, act_id);
        rs = pstmt.executeQuery();
        if (rs.next()) maxCount = rs.getInt(1);
        rs.close(); pstmt.close();
	
        // 정원 초과 시
        if (totalReserved + count > maxCount) {
        	showOverLimitModal = true;
        } else {
            // 예약번호 생성 (예: RSV20250513AB12)
            String datePart = new SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
            String randPart = UUID.randomUUID().toString().substring(0, 4).toUpperCase();
            String rsvNum = "RSV" + datePart + randPart;

            String insertSql = "INSERT INTO reservation (rsv_num, id, rsv_name, phone, count, act_id) VALUES (?, ?, ?, ?, ?, ?)";
            pstmt = conn.prepareStatement(insertSql);
            pstmt.setString(1, rsvNum);
            pstmt.setString(2, sessionId);
            pstmt.setString(3, rsv_name);
            pstmt.setString(4, phone);
            pstmt.setInt(5, count);
            pstmt.setString(6, act_id);
            pstmt.executeUpdate();
            pstmt.close();

            // 예약 완료 시
            showSuccessModal = true;
        }
    }
%>
<html>
<head>
<title>예약 상세 페이지</title>
<link rel="stylesheet" href="./resources/css/index_style.css">
<link rel="stylesheet" href="./resources/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<script src="./resources/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="./resources/css/rsv_style.css">
</head>
<body>
<div class="container py-5 mt-5">

	<!-- 예약 정보 -->
	<div class="reserve-section mt-5 mb-4 px-5">
		<%
			String sql = "SELECT * FROM activity WHERE act_id = ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, act_id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				
			String actDateStr = rs.getString("act_date");
			String formattedActDate = "";
			try {
				SimpleDateFormat inputFormat = new SimpleDateFormat("yy/M/d HH:mm");
				java.util.Date actDate = inputFormat.parse(actDateStr);

				SimpleDateFormat outputFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
				formattedActDate = outputFormat.format(actDate);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			String deadline = "";
			try {
				SimpleDateFormat sdf = new SimpleDateFormat("yy/M/d HH:mm");
				java.util.Date actDate = sdf.parse(actDateStr);
				java.util.Calendar cal = java.util.Calendar.getInstance();
				cal.setTime(actDate);
				cal.add(java.util.Calendar.DATE, -1);
				SimpleDateFormat dateOnlyFormat = new SimpleDateFormat("yyyy-MM-dd");
				deadline = dateOnlyFormat.format(cal.getTime());  // 날짜만 출력 (예: 2025-05-08)
			} catch (Exception e) {
				e.printStackTrace();
			}

			int currentCount = 0;
			String countSql = "SELECT SUM(count) FROM reservation WHERE act_id = ?";
			PreparedStatement countPstmt = conn.prepareStatement(countSql);
			countPstmt.setString(1, act_id);
			ResultSet countRs = countPstmt.executeQuery();
			if (countRs.next()) {
				currentCount = countRs.getInt(1);
			}
			if (countRs != null) countRs.close();
			if (countPstmt != null) countPstmt.close();
			
		%>
		<!-- 왼쪽 이미지 -->
		<div class="left-image mb-4 mb-md-0">
			<img src="./resources/img/<%=rs.getString("img") %>" alt="예약 이미지" class="main-image img-fluid text-center">
		</div>

		<!-- 오른쪽 정보 -->
		<div class="right-info">
			<h3 class="pb-2"><b><%=rs.getString("title") %></b><span style="font-size: 14px;">&nbsp;&nbsp;&nbsp;&nbsp;<%=rs.getString("act_id") %></span></h3>
			<p><strong>체험일자 :</strong> <%=formattedActDate%></p>
			<p><strong>마감일자 :</strong> <%=deadline%> 23:59</p>
			<p><strong>현재정원 :</strong> <%=currentCount%>명 / <%=rs.getInt("max_count") %>명</p>
			<p><strong>장소 :</strong> <%=rs.getString("address") %></p>
			<p><strong>설명</strong></p>
			<p><%=rs.getString("note") %></p>
		<%
			}
			if (rs != null) 
				rs.close();
			if (pstmt != null)
				pstmt.close();
		%>

			<!-- 예약하기 섹션 -->
			<div class="mb-3">
				<div class="p-4 border">
					<form method="post" action="reservation.jsp?act_id=<%=act_id%>">
						<div class="g-3">
							<div class="col-md-12">
								<label for="name" class="form-label">예약자명</label>
								<input type="text" name="name" id="name" class="form-control mb-2"
									placeholder="이름을 입력하세요." required>
							</div>
							<div class="col-md-12">
								<label for="phone" class="form-label">연락처</label>
								<input type="text" class="form-control mb-2" id="phone" name="phone"
									placeholder="010-0000-0000" required>
							</div>
							<div class="col-md-12">
								<label for="people" class="form-label">인원수</label>
								<div class="input-group" style="max-width: 200px;">
									<button type="button" class="btn btn-outline-secondary people-btn"
										onclick="changePeople(-1)">−</button>
									<input type="number" id="people" name="people" class="form-control text-center" value="1" 
										min="1" max="10" readonly>
									<button type="button" class="btn btn-outline-secondary people-btn"
										onclick="changePeople(1)">＋</button>
								</div>
							</div>
						</div>
						<div class="text-end mt-4">
							<button type="button" class="btn btn-success px-4 py-2"
								onclick="openConfirmModal()">예약하기</button>
						</div>
					</form>
					<!-- 예약 확인 모달 -->
					<div class="modal fade" id="confirmModal" tabindex="-1" aria-hidden="true">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<h5 class="modal-title">예약 정보 확인</h5>
									<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
								</div>
								<div class="modal-body">
									<p><strong>예약자명 : </strong> <span id="confirmName"></span></p>
									<p><strong>연락처 : </strong> <span id="confirmPhone"></span></p>
									<p><strong>인원수 : </strong> <span id="confirmPeople"></span></p>
									<p>해당 정보가 맞는지 확인해 주세요.</p>
								</div>
								<div class="modal-footer border-0">
									<button type="button" class="btn btn-primary" onclick="submitForm()">확인</button>
									<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
								</div>
							</div>
						</div>
					</div>
					<!-- 로그인 필요 모달 -->
					<div class="modal fade" id="loginRequiredModal" tabindex="-1" aria-labelledby="loginRequiredLabel" aria-hidden="true">
					  	<div class="modal-dialog">
					    	<div class="modal-content">
						      	<div class="modal-header">
							        <h5 class="modal-title" id="loginRequiredLabel">로그인 필요</h5>
							        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="닫기"></button>
						      	</div>
						      	<div class="modal-body">
						        	로그인 후 이용 가능합니다.
						      	</div>
						      	<div class="modal-footer border-0">
							        <button type="button" class="btn btn-primary" onclick="redirectToLogin()">로그인</button>
							        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
						      	</div>
					    	</div>
					  	</div>
					</div>
					<!-- 입력값 누락 모달 -->
					<div class="modal fade" id="inputRequiredModal" tabindex="-1" aria-labelledby="inputRequiredLabel" aria-hidden="true">
					  	<div class="modal-dialog">
						    <div class="modal-content">
						      	<div class="modal-header">
							        <h5 class="modal-title" id="inputRequiredLabel">입력 확인</h5>
							        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="닫기"></button>
						      	</div>
						      	<div class="modal-body">
						        	모든 항목을 입력해 주세요.
						      	</div>
						      	<div class="modal-footer border-0">
						        	<button type="button" class="btn btn-md btn-success" data-bs-dismiss="modal">확인</button>
						      	</div>
					    	</div>
					  	</div>
					</div>
					<!-- 예약 성공 모달 -->
					<div class="modal fade" id="successModal" tabindex="-1" aria-labelledby="successModalLabel" aria-hidden="true">
					  	<div class="modal-dialog">
						    <div class="modal-content">
						      	<div class="modal-header">
							        <h5 class="modal-title" id="successModalLabel">예약 완료</h5>
							        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="닫기"></button>
						      	</div>
						      	<div class="modal-body">
						        	예약이 완료되었습니다.
						      	</div>
						      	<div class="modal-footer border-0">
						        	<button type="button" class="btn btn-success" data-bs-dismiss="modal">확인</button>
						      	</div>
					    	</div>
					  	</div>
					</div>
					<!-- 정원 초과 모달 -->
					<div class="modal fade" id="overLimitModal" tabindex="-1" aria-labelledby="overLimitModalLabel" aria-hidden="true">
					  	<div class="modal-dialog">
						    <div class="modal-content">
						      	<div class="modal-header">
							        <h5 class="modal-title" id="overLimitModalLabel">정원 초과</h5>
							        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="닫기"></button>
						      	</div>
						      	<div class="modal-body">
						        	정원을 초과하였습니다.
						      	</div>
						      	<div class="modal-footer border-0">
						        	<button type="button" class="btn btn-danger" data-bs-dismiss="modal">확인</button>
						      	</div>
					    	</div>
					  	</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 활동 설명 사진 -->
	<h4 class="px-5">상세 이미지</h4>
	<div class="container-fluid px-0">
		<div id="detailCarousel" class="carousel slide mb-5 mt-2">
			<div class="carousel-inner">
				<%
					PreparedStatement sPstmt = null;
					ResultSet sRs = null;
					String imgSql = "SELECT filename FROM sub_img WHERE act_id = ? ORDER BY img_id ASC";
					sPstmt = conn.prepareStatement(imgSql);
					sPstmt.setString(1, act_id);
					sRs = sPstmt.executeQuery();
	
					List<String> subImg = new ArrayList<>();
					while (sRs.next()) {
						subImg.add(sRs.getString("filename"));
					}
	
					int groupSize = 4;
					boolean isFirst = true;
	
					for (int i = 0; i < subImg.size(); i += groupSize) {
				        int currentCount = Math.min(groupSize, subImg.size() - i); // 남은 이미지 수
				        String imgWidth = "23%";
				        if (currentCount == 3) {
				            imgWidth = "30%";
				        } else if (currentCount == 2) {
				            imgWidth = "45%";
				        } else if (currentCount == 1) {
				            imgWidth = "90%";
				        }
				%>
				<div class="carousel-item <%= isFirst ? "active" : "" %>">
				    <div class="d-flex justify-content-between custom-carousel-inner px-5">
				        <%
				            for (int j = 0; j < currentCount; j++) {
				        %>
				        <img src="./resources/img/<%= subImg.get(i + j) %>" class="d-block mx-1" alt="상세 이미지" style="width: <%= imgWidth %>;">
				        <%
				            }
				        %>
				    </div>
				</div>
				<%
				    isFirst = false; // 여기에 있어야 다음 루프에 적용됨
				    }
	
					if (sRs != null) sRs.close();
					if (sPstmt != null) sPstmt.close();
				%>
			</div>
	
			<!-- 슬라이드 버튼 -->
			<button class="carousel-control-prev" type="button" data-bs-target="#detailCarousel" data-bs-slide="prev">
				<span class="fa-solid fa-chevron-left fa-2x text-dark"></span>
			</button>
			<button class="carousel-control-next" type="button" data-bs-target="#detailCarousel" data-bs-slide="next">
				<span class="fa-solid fa-chevron-right fa-2x text-dark"></span>
			</button>
		</div>
	</div>
</div>
<%@ include file="footer.jsp"%>
</body>
<script>
	const sessionId = '<%= sessionId != null ? sessionId : "null" %>';
	// 예약 확인 모달
	function openConfirmModal() {
		// 로그인 필요 모달
		if (!sessionId || sessionId === "null") {
			const loginModal = new bootstrap.Modal(document.getElementById('loginRequiredModal'));
			loginModal.show();
			return;
		}
		const name = document.getElementById("name").value;
		const phone = document.getElementById("phone").value;
		const people = document.getElementById("people").value;

		// 입력값 누락 모달
		if (!name || !phone || !people) {
			const inputModal = new bootstrap.Modal(document.getElementById('inputRequiredModal'));
			inputModal.show();
			return;
		}

		document.getElementById("confirmName").innerText = name;
		document.getElementById("confirmPhone").innerText = phone;
		document.getElementById("confirmPeople").innerText = people;

		const modal = new bootstrap.Modal(document
				.getElementById('confirmModal'));
		modal.show();
	}
	
	function submitForm() {
		document.querySelector("form").submit();
	}
	function changePeople(delta) {
		const input = document.getElementById('people');
		let value = parseInt(input.value) || 1;
		const min = parseInt(input.min);
		const max = parseInt(input.max);

		value += delta;

		if (value < min)
			value = min;
		if (value > max)
			value = max;

		input.value = value;
	}
	
	// 로그인 하러 가기
	function redirectToLogin() {
		const returnURL = encodeURIComponent(window.location.pathname + window.location.search);
		location.href = 'login.jsp?redirect=' + returnURL;
	}

	// 예약 성공 모달
	<% if (showSuccessModal) { %>
	  const successModal = new bootstrap.Modal(document.getElementById('successModal'));
	  window.addEventListener('DOMContentLoaded', () => {
	    successModal.show();
	  });
	<% } %>
	
	// 정원 초과 모달
	<% if (showOverLimitModal) { %>
	  const overLimitModal = new bootstrap.Modal(document.getElementById('overLimitModal'));
	  window.addEventListener('DOMContentLoaded', () => {
	    overLimitModal.show();
	  });
	<% } %>
	
</script>
</html>
<%
    if (conn != null) conn.close();
%>