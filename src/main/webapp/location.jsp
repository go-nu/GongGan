<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>[사이트 이름]</title>
	<script src="./resources/js/bootstrap.bundle.min.js"></script>
	<link href="./resources/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="./resources/css/location_style.css">
</head>
<body>
    <%@ include file="header.jsp" %>
    
<!-- 슬라이드 -->
    <section class="hero">
		<div id="colorCarousel" class="carousel slide" data-bs-ride="carousel">
			<div class="carousel-inner">
		    	<div class="carousel-item active">
					<img src="./resources//img/slideimg04.jpg" class="d-block w-100" alt="...">
					<div class="fixed-caption">
					  	<h3>TOURIST ATTRACTION</h3>
					  	<p>한국의 전통 관광지와 내 스타가 다녀간 장소들</p>
					</div>
		   		</div>
		  	</div>
	  	</div>
    </section>
    
<!-- 메인 카테고리 -->
    <section class="featured-section">
        <div class="container">
            <div class="section-title">
                <h2>이번주 생일 카페</h2>
            </div>
            <%@ include file="map2.jsp" %>
        </div>
    </section>
    
<!-- 초록칸 -->
    <section class="about-section" id="lCity">
        <div class="container">
         	<div class="section-title">
	      		<h2>한국의 매력 도시</h2>
	    	</div>
            <div class="about-content">
				<div class="category-grid">
	                <div class="category-card">
	                    <img src="./resources/img/seoul.jpg" class="category-image">
	                    <div class="category-info">
	                        <h3>서울</h3>
	                        <p>전통과 현대가 어우러진 <br>대한민국의 수도</p>
	                        <div>
	                            <span class="tag">경복궁</span>
	                            <span class="tag">남산타워</span>
	                            <span class="tag">홍대거리</span>
	                        </div>
	                    </div>
	                </div>
	                <div class="category-card">
	                	<img src="./resources/img/busan.jpg" class="category-image">
	                    <div class="category-info">
	                        <h3>부산</h3>
	                        <p>바다와 도시가 만나는 <br>낭만적인 항구 도시</p>
	                        <div>
	                            <span class="tag">해운대</span>
	                            <span class="tag">광안리</span>
	                            <span class="tag">감천문화마을</span>
	                        </div>
	                    </div>
	                </div>
	                <div class="category-card">
	                    <img src="./resources/img/jeju.jpg" class="category-image">
	                    <div class="category-info">
	                        <h3>제주도</h3>
	                        <p>자연이 살아 숨 쉬는 <br>힐링 아일랜드</p>
	                        <div>
	                            <span class="tag">성산일출봉</span>
	                            <span class="tag">우도</span>
	                            <span class="tag">한라산</span>
	                        </div>
	                    </div>
	                </div>
	                <div class="category-card">
	                    <img src="./resources/img/gyeongju.jpg" class="category-image">
	                    <div class="category-info">
	                        <h3>경주</h3>
	                        <p>천년의 역사를 품은 <br>고대 왕국 신라의 도시</p>
	                        <div>
	                            <span class="tag">불국사</span>
	                            <span class="tag">첨성대</span>
	                            <span class="tag">월정교</span>
	                        </div>
	                    </div>
	                </div>
	            </div>
            </div>
        </div>
    </section>
    
<!-- 사이트 설명 -->
    <section class="community-section" id="lBoard">
        <div class="container">
            <div class="section-title">
                <h2>게시판</h2>
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
    
    
    <%@ include file="footer.jsp" %>
</body>
</html>