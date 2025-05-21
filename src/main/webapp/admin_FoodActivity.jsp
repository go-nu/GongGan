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
    <script src="./resources/js/bootstrap.bundle.min.js"></script>
	<link href="./resources/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="./resources/css/food_style2.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />
  	<script src="<%= request.getContextPath() %>/resources/js/dday.js"></script>
  	<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
</head>
<style>
.card-img-top2 {
	width:100%;
    display: block;
    margin: 0 auto;
    object-fit: cover;
    background-size: cover;
    background-position: center;
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

<!-- 메인 카테고리 (공란) -->
<section class="class-section">
	<div class="container w-100 text-end">
	</div>
</section>	

<%
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = "SELECT * FROM activity ORDER BY STR_TO_DATE(act_date, '%Y/%c/%e %H:%i') ASC";
	pstmt = conn.prepareStatement(sql);
	rs = pstmt.executeQuery();

	SimpleDateFormat sdf = new SimpleDateFormat("yy/M/d HH:mm");
	SimpleDateFormat isoFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss");
	Date now = new Date();

	// 자정 기준 시간
	Calendar cal = Calendar.getInstance();
	cal.setTime(now);
	cal.set(Calendar.HOUR_OF_DAY, 0);
	cal.set(Calendar.MINUTE, 0);
	cal.set(Calendar.SECOND, 0);
	cal.set(Calendar.MILLISECOND, 0);
	now = cal.getTime();

	String isoDateStr = ""; // D-day용 날짜 문자열
%>

<!-- 전체 체험 활동 -->
<section class="about-section">
	<div class="container">
       	<div class="section-title">
      		<h2>전체 체험 활동</h2>
     		<a class="btn btn-lg btn-primary" href="insertFoodActivity.jsp">추가 등록</a>
    	</div>

    	<!-- 카드 리스트 -->
    	<div class="container pt-3 pb-5">
    		<div class="row row-cols-1 row-cols-md-4 g-4">
<%
	while(rs.next()) {
		try {
		    String actDateStr = rs.getString("act_date");
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
				<div class="col">
			      	<div class="card h-100 shadow-sm border-0">
		        		<img src="./resources/img/<%=rs.getString("img")%>" class="card-img-top2" alt="...">
		        		<div class="card-body">
							<div class="d-flex align-items-center mb-1">
		          				<h5 class="card-title"><%=rs.getString("title")%></h5>
		          				<span class="badge d-day-badge ms-3" data-dday='<%= isoDateStr %>'></span>
		         			</div>
		          			<p class="card-text"><%=rs.getString("note")%></p>
		        		</div>
		        		<div class="card-footer bg-white border-0 text-end">
		          			<a href="adminReservation.jsp?act_id=<%=rs.getString("act_id")%>" class="btn btn-md btn-success">관리</a>
		        		</div>
			      	</div>
		    	</div>
<%
		} catch (ParseException e) {
		    continue;
		}
	}
%>
    		</div>
    	</div>
	</div>
</section>

<%@ include file="swiper.jsp" %>
<%@ include file="footer.jsp" %>

<script>
document.addEventListener("DOMContentLoaded", function () {
    // 활동 목록 로드 (선택적으로 사용할 수 있음)
    function loadActivityPage(page) {
        page = parseInt(page);
        if (isNaN(page) || page < 1) page = 1;
        const finalUrl = "foodActivityList.jsp?page=" + page;

        const xhr = new XMLHttpRequest();
        xhr.open("GET", finalUrl, true);

        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4 && xhr.status === 200) {
                document.getElementById("activityList").innerHTML = xhr.responseText;
                const savedY = sessionStorage.getItem("scrollY");
                if (savedY !== null) {
                    window.scrollTo(0, parseInt(savedY));
                    sessionStorage.removeItem("scrollY");
                }
                initDdayBadges();
                addPaginationEvent();
            }
        };
        xhr.send();
    }

    initDdayBadges();  // D-day 뱃지 초기화
});
</script>
</body>
</html>
