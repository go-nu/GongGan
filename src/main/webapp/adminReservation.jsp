<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*, java.text.*, java.sql.*" %>
<%@ include file="dbconn.jsp" %>
<%@ include file="header.jsp"%>
<%
    String sessionId = (String) session.getAttribute("id");
    String act_id = request.getParameter("act_id");

    PreparedStatement pstmt = null;
    ResultSet rs = null;

    if ("POST".equalsIgnoreCase(request.getMethod()) && request.getParameter("name") != null) {
    	// 관리자 로그인 체크
	    if (!request.isUserInRole("admin")) {
	        response.sendRedirect("adminLogin_failed.jsp");
	        return;
	    }
	
        String rsv_name = request.getParameter("name");
        int count = Integer.parseInt(request.getParameter("people"));
        String phone=request.getParameter("phone");

        if (conn == null) {
            out.println("<script>alert('DB 연결 실패'); history.back();</script>");
            return;
        }
        if (conn != null) conn.close();
        return;
    }
%>
<html>
<head>
<title>관리자 예약 상세 페이지</title>
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

			<div class="text-end mt-4">
                <a class="btn btn-md btn-outline-success" href="updateFoodActivity.jsp?ACT_ID=<%= rs.getString("ACT_ID") %>">수정</a>
                <button class="btn btn-md btn-outline-danger" onclick="confirmDelete('<%= rs.getString("ACT_ID") %>')">삭제</button>
			</div>
			<%
			}
			if (rs != null) 
				rs.close();
			if (pstmt != null)
				pstmt.close();
			%>
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
				%>
				<div class="carousel-item <%= isFirst ? "active" : "" %>">
					<div class="d-flex justify-content-between custom-carousel-inner px-5">
						<%
							for (int j = i; j < i + groupSize && j < subImg.size(); j++) {
						%>
						<img src="./resources/img/<%= subImg.get(j) %>" class="d-block mx-1" alt="상세 이미지" style="width: 23%;">
						<%
							}
						%>
					</div>
				</div>
				<%
						isFirst = false;
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

	
	<!-- 후기 섹션 -->
	<h4 class="px-5 mt-5">후기</h4>
	<div id="reviewCarousel" class="carousel slide mb-5 px-5" data-bs-interval="false">
		<div class="carousel-inner">
			<!-- 슬라이드 1 -->
			<div class="carousel-item active">
				<div class="row gx-3">
					<div class="col-md-4">
						<div class="card h-100">
							<img src="./resources/img/newyork.jpg" class="card-img-top"
								alt="후기 이미지" style="height: 250px; object-fit: cover;">
							<div class="card-body text-center">
								<p class="card-text">정말 재밌는 시간이었어요!</p>
								<small class="text-muted">by 사용자A</small>
							</div>
						</div>
					</div>
					<div class="col-md-4">
						<div class="card h-100">
							<img src="./resources/img/paris.jpg" class="card-img-top"
								alt="후기 이미지" style="height: 250px; object-fit: cover;">
							<div class="card-body text-center">
								<p class="card-text">아이랑 같이 해서 좋았어요.</p>
								<small class="text-muted">by 사용자B</small>
							</div>
						</div>
					</div>
					<div class="col-md-4">
						<div class="card h-100">
							<img src="./resources/img/img_avatar1.png" class="card-img-top"
								alt="후기 이미지" style="height: 250px; object-fit: cover;">
							<div class="card-body text-center">
								<p class="card-text">또 참가하고 싶어요!</p>
								<small class="text-muted">by 사용자C</small>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- 슬라이드 2 -->
			<div class="carousel-item">
				<div class="row gx-3">
					<div class="col-md-4">
						<div class="card h-100">
							<img src="./resources/img/newyork.jpg" class="card-img-top"
								alt="후기 이미지" style="height: 250px; object-fit: cover;">
							<div class="card-body text-center">
								<p class="card-text">후기 4!</p>
								<small class="text-muted">by 사용자D</small>
							</div>
						</div>
					</div>
					<div class="col-md-4">
						<div class="card h-100">
							<img src="./resources/img/paris.jpg" class="card-img-top"
								alt="후기 이미지" style="height: 250px; object-fit: cover;">
							<div class="card-body text-center">
								<p class="card-text">후기 5.</p>
								<small class="text-muted">by 사용자E</small>
							</div>
						</div>
					</div>
					<div class="col-md-4">
						<div class="card h-100">
							<img src="./resources/img/img_avatar1.png" class="card-img-top"
								alt="후기 이미지" style="height: 250px; object-fit: cover;">
							<div class="card-body text-center">
								<p class="card-text">후기 6!</p>
								<small class="text-muted">by 사용자F</small>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- 슬라이드 버튼 -->
		<button class="carousel-control-prev" type="button" data-bs-target="#reviewCarousel" data-bs-slide="prev">
			<span class="fa-solid fa-chevron-left fa-2x text-dark"></span>
		</button>
		<button class="carousel-control-next" type="button" data-bs-target="#reviewCarousel" data-bs-slide="next">
			<span class="fa-solid fa-chevron-right fa-2x text-dark"></span>
		</button>
	</div>
</div>
<%@ include file="footer.jsp"%>
</body>
<script>
	const sessionId = '<%= sessionId != null ? sessionId : "null" %>';
	// 모달 창
	function openConfirmModal() {
		if (!sessionId || sessionId === "null") {
			alert("로그인 후 이용 가능합니다.");
			return;
		}
		const name = document.getElementById("name").value;
		const phone = document.getElementById("phone").value;
		const people = document.getElementById("people").value;

		if (!name || !phone || !people) {
			alert("모든 항목을 입력하세요.");
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
</script>
</html>
