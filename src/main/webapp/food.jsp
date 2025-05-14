<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*"%>
<%@ page import="mvc.model.BoardDTO"%>
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
					  	<h3>K-FOOD</h3>
					  	<p>K-FOOD 한식 | 김치, 불고기, 비빔밥, 조미김, 불닭볶음면, 떡볶이</p>
					</div>
		   		</div>
		  	</div>
	  	</div>
    </section>
    
<!-- 메인 카테고리 -->
    <section class="featured-section">
        <div class="container">
            <div class="section-title">
                <h2>K-FOOD 게시판</h2>
            </div>
            <div class="my-4 board" style="min-height: 400px;">
				<!-- 게시판 미리 보기 -->
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
	      		<h2>이번 주 활동</h2>
	      		<p>25/5/5 ~ 25/5/12 활동</p>
	    	</div>
	    	
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
		            				<img src="./resources/img/<%=rs.getString("img") %>" style="width:200px; height:200px;">
		            			</div>
	            				<h3><%=rs.getString("title") %></h3>
		            			<p class="mb-1"><%=rs.getString("act_date") %></p>
								<span class="badge d-day-badge ms-3" data-dday='<%=rs.getString("act_date")%>'></span>	
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
		    <a href="foodActivity.jsp"  class="text-end mt-3">전체 활동 보기 &raquo;</a>
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