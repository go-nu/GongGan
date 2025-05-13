<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ page import="mvc.model.BoardDTO"%>
<%@ page import="mvc.model.BoardDAO"%>
<%
    BoardDTO notice = (BoardDTO) request.getAttribute("board");
    int num = ((Integer) request.getAttribute("num")).intValue();
    int nowpage = ((Integer) request.getAttribute("page")).intValue();
    
    // 현재 로그인한 사용자의 아이디
    String sessionId = (String) session.getAttribute("id");
    
    // 좋아요 상태 확인
    boolean userLiked = false;
    if(sessionId != null && !sessionId.isEmpty()) {
        BoardDAO dao = BoardDAO.getInstance();
        userLiked = dao.getLikeStatus(num, sessionId);
    }
    
    // JSP 페이지에서 사용할 수 있도록 변수 설정
    pageContext.setAttribute("userLiked", userLiked);
    pageContext.setAttribute("sessionId", sessionId);
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>K-Food Guide - 게시글 상세보기</title>
    <link rel="stylesheet" href="./resources/./css/styles.css">
    <link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
    <style>
        .like-icon {
            cursor: pointer;
            font-size: 1.2rem;
            transition: transform 0.2s;
        }
        .like-icon:hover {
            transform: scale(1.2);
        }
        .like-icon.liked {
            color: red;
        }
        .count {
            margin-left: 5px;
            font-weight: bold;
        }
    </style>
    <script type="text/javascript">
        function confirmDelete() {
            if (confirm("정말 삭제하시겠습니까?")) {
                return true;
            } else {
                return false;
            }
        }
    </script>
</head>
<body>
    <%@ include file="../header.jsp" %>

    <div class="main-container">
        <div class="content-wrap board-detail py-5" style="margin-top: 80px;">
            <div class="container">
                <h2 class="mb-4">📄 게시글 상세보기</h2>
    
                <!-- 게시글이 없을 경우 -->
                <c:if test="${empty board}">
                    <div class="alert alert-warning">
                        요청하신 게시글을 찾을 수 없습니다.
                        <div class="mt-3">
                            <a href="BoardListAction.do" class="btn btn-secondary">목록으로 돌아가기</a>
                        </div>
                    </div>
                </c:if>
    
                <!-- 게시글 있을 경우 -->
                <c:if test="${not empty board}">
                    <div class="card shadow-sm mb-5">
                        <div class="card-header bg-light">
                            <h4 class="mb-0">${board.subject}</h4>
                            <div class="small text-muted mt-1">
                                작성자: ${board.id} | 작성일: ${board.regist_day} | 조회수: ${board.hit}
                            </div>
                        </div>
                        <div class="card-body">
                            <p class="post-content">${board.content}</p>
                        </div>
                        <div class="card-footer d-flex justify-content-between align-items-center">
                            <div class="like-area">
                                <!-- 좋아요 상태에 따라 다른 아이콘 표시 -->
                                <c:choose>
                                    <c:when test="${userLiked}">
                                        <span class="like-icon liked">❤️</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="like-icon">🤍</span>
                                    </c:otherwise>
                                </c:choose>
                                <span class="count">${board.liking}</span>
                            </div>
                            <div class="btn-group">
                                <c:if test="${sessionId == board.id}">
                                    <a href="./BoardUpdateForm.do?num=${board.num}&pageNum=${page}" class="btn btn-outline-primary btn-sm">수정</a>
                                    <a href="./BoardDeleteAction.do?num=${board.num}&pageNum=${page}" 
                                       class="btn btn-outline-danger btn-sm" 
                                       onclick="return confirmDelete()">삭제</a>
                                </c:if>
                            </div>
                        </div>
                    </div>
    
                    <!-- 댓글 영역 -->
                    <div class="comment-section mb-5">
                        <h5 class="mb-3">💬 댓글</h5>
    
                        <c:if test="${empty commentList}">
                            <p class="text-muted">등록된 댓글이 없습니다.</p>
                        </c:if>
    
                        <c:if test="${not empty commentList}">
                            <ul class="list-group mb-3">
                                <c:forEach var="comment" items="${commentList}">
                                    <li class="list-group-item">
                                        <div class="d-flex justify-content-between">
                                            <strong>${comment.id}</strong>
                                            <small class="text-muted">${comment.regist_day}</small>
                                        </div>
                                        <div class="mt-1">${comment.content}</div>
                                    </li>
                                </c:forEach>
                            </ul>
                        </c:if>
    
                        <c:if test="${not empty sessionId}">
                            <form action="CommentWriteAction.do" method="post" class="mt-3">
                                <input type="hidden" name="boardNum" value="${board.num}">
                                <input type="hidden" name="pageNum" value="${page}">
                                <div class="mb-2">
                                    <textarea name="content" class="form-control" rows="3" placeholder="댓글을 입력하세요." required></textarea>
                                </div>
                                <button type="submit" class="btn btn-primary btn-sm">댓글 등록</button>
                            </form>
                        </c:if>
                    </div>
    
                    <!-- 하단 버튼 -->
                    <div class="d-flex justify-content-between">
                        <a href="BoardListAction.do?pageNum=${page}" class="btn btn-secondary">목록</a>
                        <c:if test="${not empty sessionId}">
                            <a href="BoardWriteForm.do" class="btn btn-success">새로 글쓰기</a>
                        </c:if>
                    </div>
                </c:if>
            </div>
        </div>
    </div>
    
    <%@ include file="../footer.jsp" %>

   <script>
    // 좋아요 버튼 기능
    document.addEventListener('DOMContentLoaded', function() {
        const likeButton = document.querySelector('.like-icon');
        if(likeButton) {
            likeButton.addEventListener('click', function() {
                // 세션 체크
                if("${sessionId}" === "") {
                    alert("로그인 후 이용 가능합니다.");
                    return;
                }
                
                // 좋아요 AJAX 요청 - boardNum만 전송 (세션에서 ID를 가져올 것이므로)
                fetch('BoardLikeAction.do', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                    },
                    body: `boardNum=${board.num}`
                })
                .then(response => {
                    if (!response.ok) {
                        throw new Error('Network response was not ok');
                    }
                    return response.json();
                })
                .then(data => {
                    console.log("응답 데이터:", data); // 디버깅용
                    
                    if(data.status === 'success') {
                        // 좋아요 수 업데이트
                        document.querySelector('.count').textContent = data.likeCount;
                        
                        // 좋아요 버튼 스타일 변경
                        if(data.liked) {
                            likeButton.textContent = '❤️';
                            likeButton.classList.add('liked');
                        } else {
                            likeButton.textContent = '🤍';
                            likeButton.classList.remove('liked');
                        }
                    } else {
                        alert(data.message || '좋아요 처리 중 오류가 발생했습니다.');
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('네트워크 오류가 발생했습니다.');
                });
            });
        }
    });
</script>
</body>
</html>