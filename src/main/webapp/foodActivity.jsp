<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.ParseException" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>K-FOOD 체험 활동</title>
	<script src="./resources/js/bootstrap.bundle.min.js"></script>
	<link href="./resources/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="./resources/css/food_style2.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />
  	<script src="<%= request.getContextPath() %>/resources/js/dday.js"></script>
  	<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
<%
if (request.isUserInRole("admin")) {
    response.sendRedirect("admin_FoodActivity.jsp");
    return;
}
%>
</head>
<body>
    <%@ include file="header.jsp" %>
    <%@ include file="dbconn.jsp" %>
    
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
    <section class="featured-section">
        <div class="container">
            <div class="section-title">
                <h2>다음 주 체험활동</h2>
            </div>
            <div class="mt-4 board" style="min-height: 400px;">
            	<!-- Swiper Carousel -->
		    	<div class="swiper classSwiper">
		      		<div class="swiper-wrapper">
						<%
							PreparedStatement pstmt = null;
							ResultSet rs = null;
							
						    SimpleDateFormat sdf = new SimpleDateFormat("yyyy/M/d HH:mm");
						    SimpleDateFormat sqlFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
						    SimpleDateFormat isoFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss");
						    
						    // 자정 기준 시간으로 설정
					    	Calendar nowCal = Calendar.getInstance();
							nowCal.set(Calendar.HOUR_OF_DAY, 0);
							nowCal.set(Calendar.MINUTE, 0);
							nowCal.set(Calendar.SECOND, 0);
							nowCal.set(Calendar.MILLISECOND, 0);
						    
							// 다음 주 일요일
							Calendar startCal = (Calendar) nowCal.clone();
							startCal.set(Calendar.DAY_OF_WEEK, Calendar.SUNDAY);
							startCal.add(Calendar.DATE, 7);
							Date startDate = startCal.getTime();
	                        
							// 다음 주 토요일 (23:59:59까지)
							Calendar endCal = (Calendar) startCal.clone();
							endCal.add(Calendar.DATE, 6);
							endCal.set(Calendar.HOUR_OF_DAY, 23);
							endCal.set(Calendar.MINUTE, 59);
							endCal.set(Calendar.SECOND, 59);
							endCal.set(Calendar.MILLISECOND, 999);
							Date endDate = endCal.getTime();
							
							String startDateStr = sqlFormat.format(startDate);
							String endDateStr = sqlFormat.format(endDate);
							
							// SQL: 다음 주 범위 내 활동만 가져오기
							String sql = "SELECT * FROM activity " +
							             "WHERE STR_TO_DATE(act_date, '%Y/%c/%e %H:%i') BETWEEN ? AND ? " +
							             "ORDER BY STR_TO_DATE(act_date, '%Y/%c/%e %H:%i') ASC LIMIT 4";

							pstmt = conn.prepareStatement(sql);
							pstmt.setString(1, startDateStr);
							pstmt.setString(2, endDateStr);
							rs = pstmt.executeQuery();
						    
						    // D-day가 0 이하일 때 화면에 보이지 않음
							while(rs.next()) {
								try {
								    String actDateStr = rs.getString("act_date");
								    Date actDate = sdf.parse(actDateStr);
								    String isoDateStr = isoFormat.format(actDate);
									%>
					        		<div class="swiper-slide">
					        			<a href="reservation.jsp?act_id=<%=rs.getString("act_id")%>" style="text-decoration: none; color: inherit;">
							          		<div class="class-card">
						            			<div class="class-top">
						            				<img src="./resources/img/<%=rs.getString("img") %>" style="width: 200px; height: 200px;">
						            			</div>
					            				<h3><%=rs.getString("title") %></h3>
						            			<p class="mb-1"><%=rs.getString("act_date") %></p>
												<span class="badge d-day-badge" 
													data-dday="<%= isoDateStr %>"></span>									
						          			</div>
					          			</a>
				        			</div>
	        			<%
								} catch (ParseException e) {
								    continue; // 날짜 파싱 실패한 항목은 무시
								}
							}
	        			%>
		      		</div>

					<!-- 화살표 -->
					<div class="swiper-button-prev"></div>
					<div class="swiper-button-next"></div>
			    </div>
			</div>
        </div>
    </section>
    
<!-- 체험 활동 -->
    <section class="about-section">
        <div class="container">
         	<div class="section-title">
	      		<h2 id="example" style="margin-bottom: 30px;">전체 체험활동</h2>
	      	</div>
	      	<!-- Ajax로 로딩될 카드 및 페이지 버튼 영역 -->
        <div id="activityList"></div>
	      		
        </div>
    </section>

    <section class="class-section">
		<div class="container">
			<!-- 공란 -->
	  	</div>
	</section>	
	
    <%@ include file="swiper.jsp" %>
    <%@ include file="footer.jsp" %>
    <!-- 페이지 버튼을 누를때 스크롤 유지하는 스크립트  -->
<script>
document.addEventListener("DOMContentLoaded", function () {
    // 활동 목록 로드 함수
    function loadActivityPage(page) {
        page = parseInt(page);
        if (isNaN(page) || page < 1) page = 1;
        const finalUrl = "foodActivityList.jsp?page=" + page;

        const xhr = new XMLHttpRequest();
        xhr.open("GET", finalUrl, true);

        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4 && xhr.status === 200) {
                document.getElementById("activityList").innerHTML = xhr.responseText;
             // ✅ AJAX 완료 후 스크롤 복원
                const savedY = sessionStorage.getItem("scrollY");
                if (savedY !== null) {
                    window.scrollTo(0, parseInt(savedY));
                    sessionStorage.removeItem("scrollY");
                }
                initDdayBadges();      // D-day 초기화
                addPaginationEvent();  // 페이징 버튼 다시 바인딩
            }
        };

        xhr.send();
    }

    // 페이지 버튼 이벤트 바인딩
    function addPaginationEvent() {
        document.querySelectorAll(".ajax-page").forEach(function (link) {
            link.addEventListener("click", function (e) {
                e.preventDefault(); // 링크의 기본 이동 막고
                const page = this.getAttribute("data-page");
               /*  sessionStorage.setItem("scrollY", window.scrollY); // ✅ 클릭 시 위치 저장*/
                loadActivityPage(page); // AJAX로 로딩 
                const targetElement = document.getElementById("example"); // 이동할 요소의 ID
                const targetOffset = targetElement.offsetTop - 90; // 요소의 상단 좌표
                window.scrollTo({
                	  top: targetOffset,
                	  behavior: 'smooth' // 부드러운 스크롤 효과 (선택 사항)
                	});
            });
        });
    }

    // D-day 초기화 함수 (dday.js 필요)
    function initDdayBadges() {
        if (typeof updateDdayBadges === 'function') {
            updateDdayBadges();
        }
    }

    // 첫 페이지 로딩
    // URL에서 page 파라미터 추출
    function getPageFromURL() {
        const params = new URLSearchParams(window.location.search);
        return params.get("page") || 1;
    }

    const page = getPageFromURL();
    loadActivityPage(page); // ← 추출한 page로 로딩
});

</script>
</body>
</html>