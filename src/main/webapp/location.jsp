<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="mvc.model.BoardDAO" %>
<%@ page import="mvc.model.BoardDTO" %>
<%
    BoardDAO boardDAO = BoardDAO.getInstance();
    ArrayList<BoardDTO> boardList = boardDAO.getBoardList(1, 5, null, null, "location");
    request.setAttribute("boardList", boardList);
    request.setAttribute("currentPage", 1);
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Location</title>
	<script src="./resources/js/bootstrap.bundle.min.js"></script>
	<link href="./resources/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="./resources/css/location_style.css">
</head>
<body>
    <%@ include file="header.jsp" %>
    <%@ include file="dbconn.jsp" %>
    
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
            <%@ include file="map3.jsp" %>
        </div>
    </section>
    
<!-- 초록칸 -->
    <section class="about-section" id="lCity">
        <div class="container">
         	<div class="section-title">
	      		<h2>한국의 매력 도시</h2>
	    	</div>
	    	
	    <!-- Location 관리자 CRUD 버튼 -->
        <% 
          String loginId = (String) session.getAttribute("id");
          boolean isAdmin = loginId != null && loginId.equals("admin");
          if (isAdmin) {
        %>
          <div class="text-center mb-3">
            <a href="AddLocation.jsp" class="btn btn-primary">등록</a>
            <a href="ManageLocation.jsp" class="btn btn-success">수정/삭제</a>
          </div>
        <% } %>
        
            <div class="about-content">
				<div class="category-grid">
					<%
						PreparedStatement pstmt = null;
						ResultSet rs = null;
						String sql = "SELECT * FROM city";
						
						pstmt = conn.prepareStatement(sql);
						rs = pstmt.executeQuery();
						
						while(rs.next()) {
					%>
					<a href="location_detail.jsp?city_num=<%=rs.getString("city_num")%>">
		                <div class="category-card">
		                    <img src="./resources/img/<%=rs.getString("img")%>" class="category-image">
		                    <div class="category-info">
		                        <h3><%=rs.getString("title")%></h3>
		                        <p><%=rs.getString("note")%></p>
		                        <div>
		                            <span class="tag"><%=rs.getString("tag1")%></span>
		                            <span class="tag"><%=rs.getString("tag2")%></span>
		                            <span class="tag"><%=rs.getString("tag3")%></span>
		                        </div>
		                    </div>
		                </div>
	                </a>
	                <%
						}
	                %>
	            </div>
            </div>
        </div>
    </section>
    
<!-- 사이트 설명 -->
    <section class="community-section" id="lBoard">
        <div class="container">
            <div class="section-title py-5">
                <h2>게시판</h2>
            </div>
            <!-- 게시판 미리 보기 -->
            <div class="my-4 board" style="min-height: 400px;">
				<div class="px-2 ps-sm-5">
					<a class="nav-link text-secondary" href="<c:url value='/BoardListAction.do?pageNum=1&category=location' />">more &raquo;</a>
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