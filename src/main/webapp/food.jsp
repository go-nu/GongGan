<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ page import = "java.util.*" %>
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
					<ul class="nav nav-tabs" role="tablist">
					  	<li class="nav-item" role="presentation">
						    <a class="nav-link active" data-bs-toggle="tab" href="#home" aria-selected="true" role="tab">전체 게시판</a>
					  	</li>
					  	<li class="nav-item" role="presentation">
						    <a class="nav-link" data-bs-toggle="tab" href="#c1" aria-selected="false" role="tab" tabindex="-1">맛집 공유</a>
					  	</li>
					  	<li class="nav-item" role="presentation">
						    <a class="nav-link" data-bs-toggle="tab" href="#c2" aria-selected="false" role="tab" tabindex="-1">원데이 클래스</a>
					  	</li>
					  	<li class="nav-item" role="presentation">
						    <a class="nav-link" data-bs-toggle="tab" href="#c3" aria-selected="false" role="tab" tabindex="-1">한식 레시피 공유</a>
					  	</li>
				  	  	<li class="nav-item ms-auto" role="presentation">
			    			<a class="nav-link text-secondary" href="#">more &raquo;</a>
			  			</li>
					</ul>
					<div id="myTabContent" class="tab-content  min-vh-20 max-vw-60">
						<div class="tab-pane fade active show mt-2" id="home" role="tabpanel">
					    	<p><span class="badge bg-danger me-3">공지</span> 공지 제목</p>
					    	<p><span class="badge bg-success me-3">인기</span> 인기글</p>
					    	<p><span class="badge bg-success me-3">인기</span> 인기글</p>
					    	<p><span class="badge bg-primary me-3">일반</span> 일반 제목1</p>
					    	<p><span class="badge bg-primary me-3">일반</span> 일반 제목2</p>
					    	<p><span class="badge bg-primary me-3">일반</span> 일반 제목3</p>
					  	</div>
					  	<div class="tab-pane fade mt-2" id="c1" role="tabpanel">
					    	<p><span class="badge bg-danger me-3">공지</span> 공지 제목</p>
					    	<p><span class="badge bg-success me-3">인기</span> 인기글</p>
					    	<p><span class="badge bg-primary me-3">일반</span> 일반 제목1</p>
				    	</div>
					  	<div class="tab-pane fade mt-2" id="c2" role="tabpanel">
					    	<p><span class="badge bg-danger me-3">공지</span> 공지 제목</p>
					    	<p><span class="badge bg-success me-3">인기</span> 인기글</p>
					    	<p><span class="badge bg-primary me-3">일반</span> 일반 제목1</p>
					  	</div>
					  	<div class="tab-pane fade mt-2" id="c3" role="tabpanel">
					    	<p><span class="badge bg-danger me-3">공지</span> 공지 제목</p>
					    	<p><span class="badge bg-success me-3">인기</span> 인기글</p>
					    	<p><span class="badge bg-primary me-3">일반</span> 일반 제목1</p>
				    	</div>
					</div>
				</div>
			</div>
        </div>
    </section>
    
<!-- 초록칸 -->
    <section class="about-section">
        <div class="container">
         	<div class="section-title">
         		<a href="#" class="text-primary text-end pe-20">모든 활동 보기</a>
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
		            				<img src="./resources/img/<%=rs.getString("img") %>">
		            				<span class="badge bg-secondary text-light rounded-pill ms-2">D-0</span>
		            			</div>
	            				<h3><%=rs.getString("title") %></h3>
		            			<p><%=rs.getString("act_date") %></p>
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
    </section>
    
<!-- 체험 활동 -->
    <section class="class-section">
		<div class="container">
			<div class="about-content">
                <div class="about-text">
                    <h2>지도</h2>
                    <p>근처 맛집 어쩌고 저쩌고</p>
                    <p>좋아요 / 찜 많은 것 몇개만</p>
                </div>
                <div class="about-image"></div>
            </div>
	  	</div>
	</section>	
	
    <%@ include file="swiper.jsp" %>
    <%@ include file="footer.jsp" %>
</body>
</html>