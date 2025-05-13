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
	<link rel="stylesheet" href="./resources/css/mp_style.css">
</head>
<body>
	<%@ include file="header.jsp"%>

	<!-- 슬라이드 -->
	<section class="hero">
		<div id="colorCarousel" class="carousel slide" data-bs-ride="carousel">
			<div class="carousel-inner">
				<div class="carousel-item active">
					<img src="./resources/img/slideimg01.jpg" class="d-block w-100" alt="...">
					<div class="fixed-caption">
						<h3>myPage</h3>
						<p>마이페이지</p>
					</div>
				</div>
			</div>
		</div>
	</section>

	<div class="container">
		<div class="justify-content-center">
			<div class="section-title">
				<h2>내가 작성한 글 / 댓글</h2>
				<p><%=session.getAttribute("id") %></p>
			</div>
			<section class="board-section">
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
										<a href="MyBoardAction.do?num=${board.num}&pageNum=${currentPage}" class="title-link">
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
					<div class="board-footer">
						<ul class="pagination">
							<c:if test="${pageNum > 1}">
								<li><a href="MyBoardAction.do?pageNum=${pageNum - 1}">«</a></li>
							</c:if>
							<c:forEach var="i" begin="${startPage}" end="${endPage}">
								<li <c:if test="${i == pageNum}">class="active"</c:if>>
									<a href="MyBoardAction.do?pageNum=${i}">${i}</a>
								</li>
							</c:forEach>
							<c:if test="${pageNum < total_page}">
								<li><a href="MyBoardAction.do?pageNum=${pageNum + 1}">»</a></li>
							</c:if>
						</ul>
					</div>
				</div>
			</section>
		</div>
	</div>

	<!-- 내가 작성한 글/댓글 -->
	<section class="about-section">
		<div class="container">
			<div class="section-title">
				<h2>내가 신청한 프로그램</h2>
			</div>
			
		</div>
	</section>

	<section class="community-section">
		<div class="container">
			<div class="section-title mt-3">
				<div class="d-flex justify-content-end gap-2">
					<a href="updateAccount.jsp">내 정보 수정</a>
					<span>ㆍ</span>
					<a href="#">회원 탈퇴</a>
				</div>
			</div>
		</div>
	</section>

	<%@ include file="footer.jsp"%>
</body>
</html>
