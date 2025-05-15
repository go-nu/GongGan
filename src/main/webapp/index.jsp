<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String id = (String) session.getAttribute("id");
%>
<%@ include file="dbconn.jsp"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>[사이트 이름]</title>
<script src="./resources/js/bootstrap.bundle.min.js"></script>
<link href="./resources/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="./resources/css/index_style.css">
<style>
.floating-edit-btn {
	position: fixed;
	bottom: 30px;
	right: 30px;
	z-index: 999;
	background-color: #007bff;
	color: white;
	padding: 12px 18px;
	border-radius: 30px;
	text-decoration: none;
	font-weight: bold;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
	transition: background-color 0.3s;
}

.floating-edit-btn:hover {
	background-color: #0056b3;
}
</style>
</head>
<body>
	<%@ include file="header.jsp"%>
	<%
	if (request.isUserInRole("admin")) {
	%>
	<a href="editPage.jsp?id=<%=request.getRequestURI()%>"
		class="floating-edit-btn">현재 페이지 수정</a>
	<%
	}
	%>
	<section class="hero">
		<div id="colorCarousel" class="carousel slide" data-bs-ride="carousel">
			<div class="carousel-inner">
				<%
				    // 슬라이드 정보를 DB에서 가져오기 위한 SQL 쿼리
				    String sql1 = "SELECT * FROM main"; // main 테이블에서 카테고리 정보를 가져옵니다
				    Statement pstmt1 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
				    ResultSet rs1 = pstmt1.executeQuery(sql1);
				    boolean firstItem = true; // 첫 번째 아이템을 구분하기 위해 사용
				    int currentRow = 1; // 현재 행 번호 (1부터 시작)
				    
				    // 1부터 3번까지 반복
				    while (rs1.next() && currentRow <= 3) {
				        %>
				        <div class="carousel-item <%=firstItem ? "active" : ""%>">
				            <img src="./resources/img/<%=rs1.getString("FILENAME")%>"
				                 class="d-block w-100" alt="<%=rs1.getString("TITLE")%>">
				            <div class="fixed-caption">
				                <h3><%=rs1.getString("TITLE")%></h3>
				                <p><%=rs1.getString("NOTE")%></p>
				                <!-- 태그들이 null이 아닌 경우에만 출력 -->
				                <%
				                if (rs1.getString("TAG1") != null && !rs1.getString("TAG1").isEmpty()) {
				                %>
				                <p><%=rs1.getString("TAG1")%></p>
				                <%
				                }
				                %>
				                <%
				                if (rs1.getString("TAG2") != null && !rs1.getString("TAG2").isEmpty()) {
				                %>
				                <p><%=rs1.getString("TAG2")%></p>
				                <%
				                }
				                %>
				                <%
				                if (rs1.getString("TAG3") != null && !rs1.getString("TAG3").isEmpty()) {
				                %>
				                <p><%=rs1.getString("TAG3")%></p>
				                <%
				                }
				                %>
				                <%
				                if (rs1.getString("TAG4") != null && !rs1.getString("TAG4").isEmpty()) {
				                %>
				                <p><%=rs1.getString("TAG4")%></p>
				                <%
				                }
				                %>
				                <%
				                if (rs1.getString("TAG5") != null && !rs1.getString("TAG5").isEmpty()) {
				                %>
				                <p><%=rs1.getString("TAG5")%></p>
				                <%
				                }
				                %>
				            </div>
				        </div>
				        <%
				        // 첫 번째 아이템이 처리된 후에는 "active" 클래스가 더 이상 추가되지 않도록 설정
				        firstItem = false;
				        currentRow++;  // 행 번호 증가
				    }
				    
				    rs1.close();
				    pstmt1.close();
				%>
			</div>
			<!-- Carousel Controls -->
			<button class="carousel-control-prev" type="button"
				data-bs-target="#colorCarousel" data-bs-slide="prev">
				<span class="carousel-control-prev-icon" aria-hidden="true"></span>
			</button>
			<button class="carousel-control-next" type="button"
				data-bs-target="#colorCarousel" data-bs-slide="next">
				<span class="carousel-control-next-icon" aria-hidden="true"></span>
			</button>
		</div>
	</section>

	<!-- 메인 카테고리 -->
	<section class="featured-section">
		<div class="container">
			<div class="section-title">
				<h2>메인 카테고리</h2>
			</div>
			<div class="category-grid">
				<%
				// 카테고리 정보를 DB에서 조회
				String sql2 = "SELECT * FROM main"; // main 테이블에서 카테고리 정보를 가져옵니다
				Statement pstmt2 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY); // ResultSet 타입 설정
				ResultSet rs2 = pstmt2.executeQuery(sql2);
				rs2.absolute(3); // 두 번째 행으로 이동
				// 카테고리 정보를 반복하여 출력
				while (rs2.next()) {
				%>
				<%
					String title = rs2.getString("TITLE");
					String lowerTitle = title.toLowerCase();
					String onclickUrl;
					
					if ("K-FOOD".equalsIgnoreCase(title)) {
					    onclickUrl = "food.jsp";
					} else if ("K-BEAUTY".equalsIgnoreCase(title)) {
					    onclickUrl = request.getContextPath() + "/cosmetics?action=list";
					} else if ("LOCATION".equalsIgnoreCase(title)) {
					    onclickUrl = "location.jsp";
					} else {
					    onclickUrl = lowerTitle + ".jsp";
					}
					%>
					
					<div class="category-card" onclick="location.href='<%=onclickUrl%>'" style="cursor: pointer;">
					    <img src="./resources/img/<%=rs2.getString("FILENAME")%>" class="category-image">
					    <div class="category-info">
					        <h3><%=rs2.getString("TITLE")%></h3>
					        <p><%=rs2.getString("NOTE")%></p>
					        <div>
					            <% if (rs2.getString("TAG1") != null && !rs2.getString("TAG1").isEmpty()) { %>
					                <span class="tag"><%=rs2.getString("TAG1")%></span>
					            <% } if (rs2.getString("TAG2") != null && !rs2.getString("TAG2").isEmpty()) { %>
					                <span class="tag"><%=rs2.getString("TAG2")%></span>
					            <% } if (rs2.getString("TAG3") != null && !rs2.getString("TAG3").isEmpty()) { %>
					                <span class="tag"><%=rs2.getString("TAG3")%></span>
					            <% } if (rs2.getString("TAG4") != null && !rs2.getString("TAG4").isEmpty()) { %>
					                <span class="tag"><%=rs2.getString("TAG4")%></span>
					            <% } if (rs2.getString("TAG5") != null && !rs2.getString("TAG5").isEmpty()) { %>
					                <span class="tag"><%=rs2.getString("TAG5")%></span>
					            <% } %>
					        </div>
					    </div>
					</div>

				<%
				}
				rs2.close();
				pstmt2.close();
				%>
			</div>
		</div>
	</section>

	<!-- 초록칸 -->
	<section class="about-section">
		<div class="container">
			<div class="about-content">
				<div class="about-text">
					<h2>
						한국을 방문한 <br>외국인 관광객수
					</h2>
					<p>여성 관광객이 남성보다 월등히 많음</p>
				</div>
				<div class="about-image">
					<%@ include file="chart.jsp"%>
				</div>
			</div>
		</div>
	</section>

	<!-- 사이트 설명 -->
	<section class="community-section">
		<div class="container">
			<div class="section-title">
				<h2>[사이트 이름] 사용법</h2>
				<p>사용법 어쩌고 저쩌고</p>
			</div>
			<div class="community-cards">
				<div class="community-card">
					<div class="community-icon">👨‍👩‍👧‍👦</div>
					<h3>정보 공유</h3>
					<p>
						나만의 특별한 경험과 유익한 정보를 <br>다른 이들과 나눠보아요
					</p>
				</div>
				<div class="community-card">
					<div class="community-icon">🗺</div>
					<h3>장소 찾기</h3>
					<p>
						지도를 보며 체험 장소를 찾아보거나 <br>주변 맛집을 찾아보아요
					</p>
				</div>
				<div class="community-card">
					<div class="community-icon">✍</div>
					<h3>체험 클래스</h3>
					<p>
						다양한 원데이 클래스들을 골라 <br>체험해 보아요
					</p>
				</div>
			</div>
		</div>
	</section>


	<%@ include file="footer.jsp"%>
</body>
</html>