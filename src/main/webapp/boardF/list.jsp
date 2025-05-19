<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="mvc.model.BoardDTO"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.List"%>
<%
    String sessionId = (String) session.getAttribute("id");
    
    // 카테고리 파라미터 받기 (없으면 'food'로 기본 설정)
    String category = request.getParameter("category");
    if (category == null || category.trim().isEmpty()) {
        category = "food";
    }
    
    // 카테고리 이름 매핑 (화면에 표시용)
    String categoryName = "K-Food";
    if (category.equals("beauty")) {
        categoryName = "K-Beauty";
    } else if (category.equals("location")) {
        categoryName = "K-Location";
    }
    
    // 게시판 목록
    List boardList = (List) request.getAttribute("boardList");

    Integer total_record_obj = (Integer) request.getAttribute("totalPosts");
    Integer pageNum_obj = (Integer) request.getAttribute("currentPage");
    Integer total_page_obj = (Integer) request.getAttribute("totalPage");

    int total_record = (total_record_obj != null) ? total_record_obj.intValue() : 0;
    int pageNum = (pageNum_obj != null) ? pageNum_obj.intValue() : 1;
    int total_page = (total_page_obj != null) ? total_page_obj.intValue() : 1;
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= categoryName %> Guide - 커뮤니티 게시판</title>
    <link rel="stylesheet" href="./resources/css/bootstrap.min.css">
    <link rel="stylesheet" href="./resources/css/styles.css">
    <script src="./resources/js/bootstrap.bundle.min.js"></script>
    <!-- 카테고리 탭 스타일 추가 -->
    <style>
        .category-tabs {
        display: flex;

        margin: 30px 0 20px;
        border-bottom: 2px solid #ddd;
    }
    .category-tabs a {
        padding: 10px 30px;
        margin: 0 5px;
        text-decoration: none;
        color: #333;
        border: 2px solid transparent;
        border-radius: 10px 10px 0 0;
        background-color: #f5f5f5;
        font-weight: 500;
        transition: all 0.2s ease;
    }
    .category-tabs a:hover {
        background-color: #eaeaea;
    }
    .category-tabs a.active {
        background-color: #ffffff;
        border: 2px solid #e74c3c;
        border-bottom: 2px solid white;
        font-weight: bold;
        color: #e74c3c;
    }
    
    </style>
    <script type="text/javascript">
    var id = "<%= session.getAttribute("id") != null ? session.getAttribute("id") : "" %>";
    
    function showModal(message) {
        const modal = new bootstrap.Modal(document.getElementById("alertModal"));
        document.getElementById("alertMessage").textContent = message;
        modal.show();
    }
    
    function checkForm() {
        const id = "<%= sessionId != null ? sessionId : "" %>";
        if (id === "") {
            showModal("로그인 후 이용 가능합니다.");
            return false;
        }
        location.href = "./BoardWriteForm.do?id=" + id + "&category=<%= category %>";
    }
    </script>
</head>
<body>
    <%@ include file="../header.jsp" %>

    <section class="board-section">
        <div class="container">
            <div class="board-header">
                <h1><%= categoryName %> 게시판</h1>
                <p><%= categoryName %>에 관한 자유로운 의견을 나누는 공간입니다.</p>
            </div>
            
            <!-- 카테고리 탭 네비게이션 추가 -->
            <div class="category-tabs">
                <a href="BoardListAction.do?category=food" class="<%= category.equals("food") ? "active" : "" %>">K-Food</a>
                <a href="BoardListAction.do?category=beauty" class="<%= category.equals("beauty") ? "active" : "" %>">K-Beauty</a>
                <a href="BoardListAction.do?category=location" class="<%= category.equals("location") ? "active" : "" %>">K-Location</a>
            </div>
            
            <div class="board-options">
                <div class="total-posts">
                    총 게시물 <strong>${total_record}</strong>건
                </div>
                <div class="search-container">
                    <form action="BoardListAction.do" method="get">
                        <input type="hidden" name="category" value="<%= category %>">
                        <select name="items" class="search-select">
                            <option value="subject" <c:if test="${param.items eq 'subject'}">selected</c:if>>제목</option>
                            <option value="content" <c:if test="${param.items eq 'content'}">selected</c:if>>내용</option>
                            <option value="id" <c:if test="${param.items eq 'id'}">selected</c:if>>글쓴이</option>
                        </select>
                        <input type="text" name="text" class="search-input" placeholder="검색어를 입력하세요" value="${param.text}">
                        <button type="submit" class="search-btn">검색</button>
                    </form>
                </div>
            </div>
            
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
					            <a href="BoardViewAction.do?num=${board.num}&pageNum=${currentPage}&category=<%= category %>" class="title-link">
					                <!-- 공지 뱃지 -->
					                <c:if test="${board.id == 'admin'}">
					                    <span class="badge bg-danger me-1">공지</span>
					                </c:if>
					
					                ${board.subject}
					                
					                <c:if test="${not empty board.fileName}">
					                    <i class="bi bi-paperclip"></i>
					                </c:if>
					
					                <c:if test="${board.comment_count > 0}">
					                    <span class="comment-count">${board.comment_count}</span>
					                </c:if>
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
                        <li><a href="BoardListAction.do?pageNum=${pageNum - 1}&category=<%= category %><c:if test="${not empty param.items}">&items=${param.items}</c:if><c:if test="${not empty param.text}">&text=${param.text}</c:if>">«</a></li>
                    </c:if>
                    
                    <c:forEach var="i" begin="${startPage}" end="${endPage}">
                        <li <c:if test="${i == pageNum}">class="active"</c:if>>
                            <a href="BoardListAction.do?pageNum=${i}&category=<%= category %><c:if test="${not empty param.items}">&items=${param.items}</c:if><c:if test="${not empty param.text}">&text=${param.text}</c:if>">${i}</a>
                        </li>
                    </c:forEach>
                    
                    <c:if test="${pageNum < total_page}">
                        <li><a href="BoardListAction.do?pageNum=${pageNum + 1}&category=<%= category %><c:if test="${not empty param.items}">&items=${param.items}</c:if><c:if test="${not empty param.text}">&text=${param.text}</c:if>">»</a></li>
                    </c:if>
                </ul>
                
                <button onclick="checkForm()" class="write-btn">글쓰기</button>
            </div>
        </div>
    </section>
	<!-- 부트스트랩 알림 모달 -->
	<div class="modal fade" id="alertModal" tabindex="-1" aria-labelledby="alertModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="alertModalLabel">알림</h5>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="닫기"></button>
	      </div>
	      <div class="modal-body" id="alertMessage">
	        <!-- 자바스크립트에서 메시지가 삽입됩니다 -->
	      </div>
	      <div class="modal-footer border-0">
	        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">확인</button>
	      </div>
	    </div>
	  </div>
	</div>
    <%@ include file="../footer.jsp" %>
</body>
</html>