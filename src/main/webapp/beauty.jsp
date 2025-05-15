<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="mvc.model.CosmeticsDTO" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>K-BEAUTY</title>
  <link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/bootstrap.min.css">
  <link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/beauty_style.css">
</head>
<body>

<%@ include file="header.jsp" %>

<!--  상단 이미지 섹션 -->
<section class="hero">
  <div class="carousel-inner">
    <div class="carousel-item active">
      <img src="<%= request.getContextPath() %>/resources/img/BEAUTY09.jpg" class="d-block w-100" alt="K-BEAUTY">
      <div class="fixed-caption">
        <h3>K-BEAUTY</h3>
        <p>Experience the Secrets of Korean Skincare</p>
      </div>
    </div>
  </div>
</section>

<!--  화장품 섹션  -->
<section class="featured-section">
	<div class="container">
    <%
      List<CosmeticsDTO> allCosmetics = (List<CosmeticsDTO>) request.getAttribute("cosmeticsList");

      Map<String, List<CosmeticsDTO>> categorizedCosmetics = new HashMap<>();
      for (CosmeticsDTO cosmetic : allCosmetics) {
        String category = cosmetic.getCategory();
        categorizedCosmetics.computeIfAbsent(category, k -> new ArrayList<>()).add(cosmetic);
      }

      for (Map.Entry<String, List<CosmeticsDTO>> entry : categorizedCosmetics.entrySet()) {
        String categoryName = entry.getKey();
        List<CosmeticsDTO> categoryCosmetics = entry.getValue();
    %>
    <div class="mb-2">
      <div class="d-flex justify-content-between align-items-center mb-3">
        <h3><%= categoryName %></h3>
        <a href="cosmetics?action=category&category=<%= categoryName %>" class="btn btn-sm btn-outline-secondary">더보기(More)</a>
      </div>
      <div class="row row-cols-1 row-cols-md-4 g-4">
        <%
          int displayCount = 0;
          for (CosmeticsDTO cosmetic : categoryCosmetics) {
            if (displayCount++ >= 4) break;
        %>
        <div class="col">
          <div class="card h-100 shadow-sm border-0" style="height: 300px;">
            <img src="<%= request.getContextPath() %>/resources/img/<%= cosmetic.getImage_file() %>" class="card-img-top" alt="<%= cosmetic.getName() %>" style="height: 200px; object-fit: cover;">
            <div class="card-body p-2 text-center" style="height: 120px; overflow: hidden;">
              <h5 class="card-title mb-2"><%= cosmetic.getName() %></h5>
              <p class="card-text small text-muted mb-2">주요 성분: <%= cosmetic.getMain_ingredient() %></p>
              <div style="font-size: 12px; color: #d33; line-height: 1; margin-bottom: 6px;">
				  ❤️ <span style="font-size: 12px; color: #333;"><%= cosmetic.getLikes() %></span>
			  </div>
              <a href="cosmetics?action=detail&id=<%= cosmetic.getId() %>" class="btn btn-sm btn-outline-primary">상세보기</a>
            </div>
          </div>
        </div>
        <% } %>
      </div>
    </div>
    <% } %>
  </div>
</section>

<!--  중단 -->
<section class="about-section" id="storeMap">
  	<div class="container text-center py-5">
    	<%@ include file="map.jsp" %>
    </div>
</section>

<!-- 하단 -->
<section class="class-section" id="beautyBoard">
  <div class="container text-center py-5">
    <h4 class="text-muted">하단</h4>
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
<script src="<%= request.getContextPath() %>/resources/js/bootstrap.bundle.min.js"></script>
</body>
</html>
