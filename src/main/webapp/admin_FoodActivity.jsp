<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import = "java.util.*, java.text.*, java.sql.*" %>
<%@ page import="java.util.Date" %>
<%@ include file="dbconn.jsp" %>
<%@ include file="header.jsp"%>
<%
	// 관리자 로그인 체크
    if (!request.isUserInRole("admin")) {
        response.sendRedirect("adminLogin_failed.jsp");
        return;
    }
%>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>관리자 체험 활동</title>
    <link rel="stylesheet" href="./resources/css/food_style2.css">
	<link href="./resources/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />
	<script src="./resources/js/bootstrap.bundle.min.js"></script>
  	<script src="<%= request.getContextPath() %>/resources/js/dday.js"></script>
  	<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
</head>
<style>
.btn-primary {
	
}
</style>
<body> 
<!-- 슬라이드 -->
	<section class="hero">
		<div id="colorCarousel" class="carousel slide" data-bs-ride="carousel">
			<div class="carousel-inner">
		    	<div class="carousel-item active">
					<img src="./resources/img/slideimg01.jpg" class="d-block w-100" alt="...">
					<div class="fixed-caption">
					  	<h3>K-FOOD, 직접 만들고 맛보다</h3>
					  	<p>한국의 맛을 경험하는 특별한 하루, 우리 함께해요!</p>
					</div>
		   		</div>
		  	</div>
	  	</div>
    </section>
    
<!-- 메인 카테고리 -->
<section class="class-section">
	<div class="container w-100  text-end">
		
  	</div>
</section>	
<%
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = "SELECT * FROM activity ORDER BY STR_TO_DATE(act_date, '%Y/%c/%e %H:%i') ASC limit 4";
	
	pstmt = conn.prepareStatement(sql);
	rs = pstmt.executeQuery();
	
    SimpleDateFormat sdf = new SimpleDateFormat("yy/M/d HH:mm");
    Date now = new Date();
    // 자정 기준 시간으로 설정
    Calendar cal = Calendar.getInstance();
    cal.setTime(now);
    cal.set(Calendar.HOUR_OF_DAY, 0);
    cal.set(Calendar.MINUTE, 0);
    cal.set(Calendar.SECOND, 0);
    cal.set(Calendar.MILLISECOND, 0);
    now = cal.getTime();
    
 	// 오늘 기준 시간 정리
   	Calendar nowCal = Calendar.getInstance();
    nowCal.set(Calendar.HOUR_OF_DAY, 0);
    nowCal.set(Calendar.MINUTE, 0);
    nowCal.set(Calendar.SECOND, 0);
    nowCal.set(Calendar.MILLISECOND, 0);
    
    // 이번 주 일요일
    Calendar startCal = (Calendar) nowCal.clone();
    startCal.set(Calendar.DAY_OF_WEEK, Calendar.SUNDAY);

    // 다음 주 일요일 = 이번 주 일요일 + 7일
    startCal.add(Calendar.DATE, 7);
    Date startDate = startCal.getTime();

    // 다음 주 토요일 = 다음 주 일요일 + 6일
    Calendar endCal = (Calendar) startCal.clone();
    endCal.add(Calendar.DATE, 6);
    Date endDate = endCal.getTime();
    
    SimpleDateFormat isoFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss");
    String isoDateStr = ""; // try-catch 외부에서 미리 선언
    
    // D-day가 0 이하일 때 화면에 보이지 않음
	while(rs.next()) {
		try {
		    String actDateStr = rs.getString("act_date");
		    Date actDate = sdf.parse(actDateStr);
		    // 자정 기준으로 변환
            Calendar actCal = Calendar.getInstance();
            actCal.setTime(actDate);
            actCal.set(Calendar.HOUR_OF_DAY, 0);
            actCal.set(Calendar.MINUTE, 0);
            actCal.set(Calendar.SECOND, 0);
            actCal.set(Calendar.MILLISECOND, 0);
            actDate = actCal.getTime();

		    long diff = actDate.getTime() - now.getTime();
		    long days = (long) Math.ceil((double) diff / (24 * 60 * 60 * 1000));

		    isoDateStr = isoFormat.format(actDate);

		} catch (ParseException e) {
		    continue; // 날짜 파싱 실패한 항목은 무시
		}
	}
%>

<!-- 전체 체험 활동 -->
<section class="about-section">
	<div class="container">
       	<div class="section-title">
      		<h2>전체 체험 활동</h2>
      		<div class="container text-end w-100 my-5">
      			<a class="btn btn-lg btn-warning" href="updateFoodActivity.jsp">추가 등록</a>
      		</div>
      		<!-- 4카드 섹션  -->
			<div class="container pt-3 pb-5">
				<div class="row row-cols-1 row-cols-md-4 g-3">
					<%
					PreparedStatement pstmtS = null;
					ResultSet rsS = null;
					String sqlS = "select * from activity ORDER BY STR_TO_DATE(act_date, '%Y/%c/%e %H:%i')";
					
					pstmtS = conn.prepareStatement(sqlS);
					rsS = pstmtS.executeQuery();
					
					// D-day가 0 이하일 때 화면에 보이지 않음
					while(rsS.next()) {
						try {
						    String actDateStr = rsS.getString("act_date");
						    Date actDate = sdf.parse(actDateStr);
                            Calendar actCal = Calendar.getInstance();
                            actCal.setTime(actDate);
                            actCal.set(Calendar.HOUR_OF_DAY, 0);
                            actCal.set(Calendar.MINUTE, 0);
                            actCal.set(Calendar.SECOND, 0);
                            actCal.set(Calendar.MILLISECOND, 0);
                            actDate = actCal.getTime();

						    long diff = actDate.getTime() - now.getTime();
						    long days = (long) Math.ceil((double) diff / (24 * 60 * 60 * 1000));

						    if (days <= 0) continue;
						    isoDateStr = isoFormat.format(actDate);
							%>
									
					    	<!-- 카드 -->
					    	<div class="col">
					      		<div class="card h-100 shadow-sm border-0">
					        		<img src="./resources/img/<%=rsS.getString("img")%>" class="card-img-top2" alt="...">
					        		<div class="card-body">
										<div class="d-flex align-items-center mb-1">
					          				<h5 class="card-title"><%=rsS.getString("title")%></h5>
					          				<span class="badge d-day-badge ms-3" 
					          					data-dday='<%= isoDateStr %>'></span>
					         			</div>
					          			<div class="d-flex align-items-center gap-3 small text-muted mb-2">
						            		<div><i class="bi bi-eye"></i> 120</div>
						            		<div><i class="bi bi-chat-left"></i> 3</div>
						            		<div><i class="bi bi-heart"></i> 15</div>
					          			</div>
					          		<p class="card-text"><%=rsS.getString("note")%></p>
					        		</div>
					        		<div class="card-footer bg-white border-0 text-end">
					          			<a href="adminReservation.jsp?act_id=<%=rsS.getString("act_id")%>" class="btn btn-md btn-primary">관리</a>
					        		</div>
					      		</div>
					    	</div>
					    	<%
						} catch (ParseException e) {
						    continue; // 날짜 파싱 실패한 항목은 무시
						}
					}
			    	%>
				</div>
			</div>
		</div>
	</div>
</section>

<section class="class-section">
	<div class="container">
		<!-- 공란 -->
  	</div>
</section>	
	
    <%@ include file="swiper.jsp" %>
    <%@ include file="footer.jsp" %>
</body>
</html>