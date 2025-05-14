<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*"%>
<%@ page import="mvc.model.BoardDTO"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.ParseException" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>[사이트 이름]</title>
	<script src="./resources/js/bootstrap.bundle.min.js"></script>
	<link href="./resources/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="./resources/css/food_style.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />
  	<script src="<%= request.getContextPath() %>/resources/js/dday.js"></script>
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
					  	<h3>K-FOOD</h3>
					  	<p>K-FOOD 한식 | 김치, 불고기, 비빔밥, 조미김, 불닭볶음면, 떡볶이</p>
					</div>
		   		</div>
		  	</div>
	  	</div>
    </section>
    
<!-- 메인 카테고리 -->
    <section class="featured-section" id="foodBoard">
        <div class="container">
            <div class="section-title">
                <h2>K-FOOD 게시판</h2>
            </div>
            <!-- 게시판 미리 보기 -->
            <div class="my-4 board" style="min-height: 400px;">
				<div class="px-2 ps-sm-5">
					<a class="nav-link text-secondary" href="<c:url value="/BoardListAction.do?pageNum=1&items=${items}&text=${text}"/>">more &raquo;</a>
					<div class="board-section">
						<div class="container">
							<table class="board-table">
								<thead>
									<tr>
										<th class="post-number">번호</th>
										<th class="post-title">제목</th>
										<th class="post-author">글쓴이</th>
										<th class="post-date">작성일</th>
										<th class="post-views">조회수</th>
									</tr>
								</thead>
								<tbody>
									<c:if test="${empty boardList}">
										<tr>
											<td colspan="5" style="text-align: center; padding: 50px 0;">등록된 게시글이 없습니다.</td>
										</tr>
									</c:if>
									<c:forEach var="board" items="${boardList}">
										<tr>
											<td class="post-number">${board.num}</td>
											<td class="post-title">
												<a href="BoardViewAction.do?num=${board.num}&pageNum=${currentPage}" class="title-link">
													${board.subject}
												</a>
											</td>
											<td class="post-author">${board.id}</td>
											<td class="post-date">${board.regist_day}</td>
											<td class="post-views">${board.hit}</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
			  	</div>
			</div>
		</div>
    </section>
    
<!-- 체험 활동 -->
    <section class="about-section">
        <div class="container">
         	<div class="section-title">
	      		<h2>다음 주 체험활동</h2>
	      		<!-- <p>25/5/5 ~ 25/5/12 활동</p> -->
	    	</div>
	    	
    		<!-- Swiper Carousel -->
	    	<div class="swiper classSwiper">
	      		<div class="swiper-wrapper">
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

							 	// 다음 주 범위 안에 없으면 건너뜀
                                if (actDate.before(startDate) || actDate.after(endDate)) continue;

							    isoDateStr = isoFormat.format(actDate);
								%>
				        		<div class="swiper-slide">
				        			<a href="reservation.jsp?act_id=<%=rs.getString("act_id")%>" style="text-decoration: none; color: inherit;">
						          		<div class="class-card">
					            			<div class="class-top">
					            				<img src="./resources/img/<%=rs.getString("img") %>" style="width: 200px; height: 200px;">
					            			</div>
				            				<h3><%=rs.getString("title") %></h3>
					            			<p class="mb-1"><%=rs.getString("act_date") %></p>
											<span class="badge d-day-badge ms-3" 
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
		    <a href="foodActivity.jsp"  class="text-end mt-5">전체 활동 보기 &raquo;</a>
        </div>
    </section>
    
<!--  -->
    <section class="class-section">
		<div class="container">
			<div class="about-content">
                <div class="about-text">
                    <h2>내가 만드는 한식</h2>                    
                    <p>인기 있는 레시피를 모아 봣어요</p>
                </div>
                <div class="about-image"></div>
            </div>
		    <a href="#"  class="text-end mt-3">전체 활동 보기 &raquo;</a>
	  	</div>
	</section>	
	
    <%@ include file="swiper.jsp" %>
    <%@ include file="footer.jsp" %>
</body>
</html>