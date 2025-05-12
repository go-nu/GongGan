<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ page import = "java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>[사이트 이름]</title>
	<script src="./resources/js/bootstrap.bundle.min.js"></script>
	<link href="./resources/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="./resources/css/food_style2.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />
	<script src="./resources/js/swiper-init.js"></script>
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
                <h2>마감 직전 체험활동</h2>
            </div>
            <div class="mt-4 board" style="min-height: 400px;">
            	<!-- Swiper Carousel -->
		    	<div class="swiper classSwiper">
		      		<div class="swiper-wrapper">
						<%
							PreparedStatement pstmt = null;
							ResultSet rs = null;
							String sql = "select * from activity";
							
							pstmt = conn.prepareStatement(sql);
							rs = pstmt.executeQuery();
							while(rs.next()) {
								
						%>
		        		<div class="swiper-slide">
		        			<a href="reservation.jsp?act_id=<%=rs.getString("act_id")%>" style="text-decoration: none; color: inherit;">
				          		<div class="class-card">
			            			<div class="class-top">
			            				<img src="./resources/img/<%=rs.getString("img") %>">
			            			</div>
		            				<h3><%=rs.getString("title") %></h3>
			            			<p class="mb-1"><%=rs.getString("act_date") %></p>
			            			<%
									    String actDateStr = rs.getString("act_date");
									
									    // SimpleDateFormat은 두 자릿수 연도("25")를 2025로 해석하게 패턴 지정 필요
									    java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yy/MM/dd HH:mm");
									    java.util.Date actDate = sdf.parse(actDateStr);
	
									    java.util.Calendar today = java.util.Calendar.getInstance();
									    today.set(java.util.Calendar.HOUR_OF_DAY, 0);
									    today.set(java.util.Calendar.MINUTE, 0);
									    today.set(java.util.Calendar.SECOND, 0);
									    today.set(java.util.Calendar.MILLISECOND, 0);
	
									    java.util.Calendar actCal = java.util.Calendar.getInstance();
									    actCal.setTime(actDate);
									    actCal.set(java.util.Calendar.HOUR_OF_DAY, 0);
									    actCal.set(java.util.Calendar.MINUTE, 0);
									    actCal.set(java.util.Calendar.SECOND, 0);
									    actCal.set(java.util.Calendar.MILLISECOND, 0);
									    
									    long diffMillis = actCal.getTimeInMillis() - today.getTimeInMillis();
									    long diffDays = diffMillis / (24 * 60 * 60 * 1000);
									%>
									<span class="badge bg-secondary text-light rounded-pill ms-2">D-<%=diffDays %></span>
			          			</div>
		          			</a>
	        			</div>
	        			<%
							}
							if (rs != null) 
								rs.close();
							if (pstmt != null)
								pstmt.close();
							if (conn != null)
								conn.close();
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
	      		<h2>전체 체험활동</h2>
	      		<p> [게시판 들어갈 자리] </p>
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