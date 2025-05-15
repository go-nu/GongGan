<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="mvc.model.BoardDTO"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.List"%>
<%
    String sessionId = (String) session.getAttribute("id");
	List boardList = (List) request.getAttribute("boardList");	
	int total_record = ((Integer) request.getAttribute("totalPosts")).intValue();
	int pageNum = ((Integer) request.getAttribute("currentPage")).intValue();
	int total_page = ((Integer) request.getAttribute("totalPage")).intValue();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>K-Food Guide - 커뮤니티 게시판</title>
    <link rel="stylesheet" href="./resources/css/styles.css">
    <script type="text/javascript">
    var id = "<%= session.getAttribute("id") != null ? session.getAttribute("id") : "" %>";
    
    function checkForm() {
        if ("${id}" == "") {
            alert("로그인 해주세요.");
            return false;
        }
        location.href = "./BoardWriteForm.do?id=${id}";
    }
    </script>
</head>
<body>
    <%@ include file="../header.jsp" %>

    <section class="board-section">
        <div class="container">
            <div class="board-header">
                <h1>자유 게시판</h1>
                <p>자유로운 의견을 나누는 공간입니다.</p>
            </div>
            
            <div class="board-options">
                <div class="total-posts">
                    총 게시물 <strong>${total_record}</strong>건
                </div>
                <div class="search-container">
                    <form action="BoardListAction.do" method="get">
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
                                <a href="BoardViewAction.do?num=${board.num}&pageNum=${currentPage}" class="title-link">
                                    ${board.subject}
                                    <c:if test="${not empty board.fileName}">
							            <i class="bi bi-paperclip"></i> <!-- 첨부파일 아이콘 -->
							        </c:if>
                                    <!-- 댓글 수 표시 기능 임시 제거 -->
                                    <%-- <c:if test="${board.comment_count > 0}">
                                        <span class="comment-count">${board.comment_count}</span>
                                    </c:if> --%>
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
                        <li><a href="BoardListAction.do?pageNum=${pageNum - 1}<c:if test="${not empty param.items}">&items=${param.items}</c:if><c:if test="${not empty param.text}">&text=${param.text}</c:if>">«</a></li>
                    </c:if>
                    
                    <c:forEach var="i" begin="${startPage}" end="${endPage}">
                        <li <c:if test="${i == pageNum}">class="active"</c:if>>
                            <a href="BoardListAction.do?pageNum=${i}<c:if test="${not empty param.items}">&items=${param.items}</c:if><c:if test="${not empty param.text}">&text=${param.text}</c:if>">${i}</a>
                        </li>
                    </c:forEach>
                    
                    <c:if test="${pageNum < total_page}">
                        <li><a href="BoardListAction.do?pageNum=${pageNum + 1}<c:if test="${not empty param.items}">&items=${param.items}</c:if><c:if test="${not empty param.text}">&text=${param.text}</c:if>">»</a></li>
                    </c:if>
                </ul>
                
                <button onclick="checkForm()" class="write-btn">글쓰기</button>
            </div>
        </div>
    </section>

    <%@ include file="../footer.jsp" %>
</body>
</html>