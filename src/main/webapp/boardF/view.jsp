<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ page import="mvc.model.BoardDTO"%>
<%@ page import="mvc.model.BoardDAO"%>
<%@ page import="mvc.util.FileUtil" %>
<%
    BoardDTO notice = (BoardDTO) request.getAttribute("board");
    int num = ((Integer) request.getAttribute("num")).intValue();
    int nowpage = ((Integer) request.getAttribute("page")).intValue();
    String category = (String) request.getAttribute("category");

    if (category == null || category.trim().equals("")) category = "food";
    
    // 현재 로그인한 사용자의 아이디
    String sessionId = (String) session.getAttribute("id");
    
    // 좋아요 상태 확인
    boolean userLiked = false;
    if(sessionId != null && !sessionId.isEmpty()) {
        BoardDAO dao = BoardDAO.getInstance();
        userLiked = dao.getLikeStatus(num, sessionId);
    }
	boolean isAdmin = request.isUserInRole("admin");
	pageContext.setAttribute("isAdmin", isAdmin);
    // JSP 페이지에서 사용할 수 있도록 변수 설정
    pageContext.setAttribute("page", nowpage); // 250514 첨부파일 추가및 수정 중 추가
    pageContext.setAttribute("userLiked", userLiked);
    pageContext.setAttribute("sessionId", sessionId);
    pageContext.setAttribute("category", category);
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
<!--     <meta name="viewport" content="width=device-width, initial-scale=1.0"> -->
    <title><c:out value="${board.subject}"/> - 상세보기</title>
    <link rel="stylesheet" href="./resources/css/styles.css">
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
        /* 댓글 스타일 추가 */
        .comment-block {
            border-bottom: 1px solid #eee;
            padding: 10px 0;
        }
        .comment-block:last-child {
            border-bottom: none;
        }
        .comment-actions {
            margin-top: 5px;
        }
        .comment-actions .btn {
            margin-right: 5px;
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
        
        function confirmCommentDelete() {
            if (confirm("댓글을 삭제하시겠습니까?")) {
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
                                <c:if test="${sessionId == board.id || isAdmin}">
                                    <a href="./BoardUpdateForm.do?num=${board.num}&pageNum=${page}&category=${board.category}" class="btn btn-outline-success btn-sm">수정</a>
                             <a href="./BoardDeleteAction.do?num=${board.num}&pageNum=${page}&category=${board.category}" 
                                       class="btn btn-outline-danger btn-sm" 
                                       onclick="return confirmDelete()">삭제</a>
                                </c:if>
                            </div>
                        </div>
                        <!-- 첨부파일 정보 표시 부분을 추가 -->
                  <!-- 첨부파일 정보 표시 부분 수정 - 간격 추가 -->
                  <div class="card-footer bg-light border-top py-3">
                      <div class="row align-items-center">
                          <div class="col-md-3">
                              <span class="fw-bold">첨부파일</span>
                          </div>
                          <div class="col-md-9">
                              <c:choose>
                                  <c:when test="${not empty board.fileName}">
                                      <a href="FileDownloadServlet?num=${board.num}" class="btn btn-sm btn-outline-secondary">
                                          <i class="bi bi-download"></i> ${board.originalFileName}
                                      </a>
                                      <small class="text-muted ms-2">(${FileUtil.formatFileSize(board.fileSize)})</small>
                                  </c:when>
                                  <c:otherwise>
                                      <span class="text-muted">첨부파일 없음</span>
                                  </c:otherwise>
                              </c:choose>
                          </div>
                      </div>
                  </div>
                  </div>
                  
                  <!-- 간격 추가 -->
                  <div class="my-4"></div>
                  
                  <!-- 댓글 영역 - 페이징 추가 및 수정/삭제 기능 추가 -->
                  <div class="comment-section mb-5">
                      <h5 class="mb-3">💬 댓글</h5>
                  
                      <c:if test="${empty commentList}">
                          <p class="text-muted">등록된 댓글이 없습니다.</p>
                      </c:if>
                  
                      <c:if test="${not empty commentList}">
                          <!-- 페이징을 위한 변수 설정 -->
                          <c:set var="commentsPerPage" value="5" />
                          <c:set var="totalComments" value="${commentList.size()}" />
                          <c:set var="totalPages" value="${(totalComments + commentsPerPage - 1) / commentsPerPage}" />
                          <c:set var="currentCommentPage" value="${param.commentPage != null ? param.commentPage : 1}" />
                          
                          <ul class="list-group mb-3">
                              <!-- 현재 페이지에 해당하는 댓글만 표시 -->
                              <c:forEach var="comment" items="${commentList}" varStatus="status">
                                  <c:if test="${status.index >= (currentCommentPage-1) * commentsPerPage && status.index < currentCommentPage * commentsPerPage}">
                                      <li class="list-group-item">
                                          <div class="d-flex justify-content-between">
                                              <strong>${comment.id}</strong>
                                              <small class="text-muted">${comment.regist_day}</small>
                                          </div>
                                          
                                                <!-- 댓글 수정 모드일 때와 일반 모드일 때 구분 -->
                                                <c:choose>
                                                    <c:when test="${param.edit_id == comment.num}">
                                                        <!-- 댓글 수정 폼 -->
                                                        <form action="CommentUpdateAction.do" method="post" class="mt-2">
                                                            <input type="hidden" name="num" value="${comment.num}">
                                                            <input type="hidden" name="boardNum" value="${board.num}">
                                                            <input type="hidden" name="pageNum" value="${page}">
                                                            <input type="hidden" name="commentPage" value="${currentCommentPage}">
                                                            <div class="form-group">
                                                                <textarea name="content" class="form-control mb-2" rows="2" required>${comment.content}</textarea>
                                                            </div>
                                                            <div class="d-flex">
                                                                <button type="submit" class="btn btn-sm btn-success me-2">저장</button>
                                                                <a href="BoardViewAction.do?num=${board.num}&pageNum=${page}&commentPage=${currentCommentPage}" 
                                                                   class="btn btn-sm btn-secondary">취소</a>
                                                            </div>
                                                        </form>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <!-- 댓글 내용 표시 -->
                                                        <div class="mt-1">${comment.content}</div>
                                                        
                                                        <!-- 댓글 작성자인 경우에만 수정/삭제 버튼 표시 -->
                                                        <c:if test="${sessionId == comment.id}">
                                                            <div class="d-flex mt-2">
                                                                <a href="BoardViewAction.do?num=${board.num}&pageNum=${page}&commentPage=${currentCommentPage}&edit_id=${comment.num}" 
                                                                   class="btn btn-sm btn-outline-success me-2">수정</a>
                                                                <form action="CommentDeleteAction.do" method="post">
                                                                    <input type="hidden" name="num" value="${comment.num}">
                                                                    <input type="hidden" name="boardNum" value="${board.num}">
                                                                    <input type="hidden" name="pageNum" value="${page}">
                                                                    <input type="hidden" name="commentPage" value="${currentCommentPage}">
                                                                    <button type="submit" class="btn btn-sm btn-outline-danger" 
                                                                            onclick="return confirmCommentDelete()">삭제</button>
                                                                </form>
                                                            </div>
                                                        </c:if>
                                                    </c:otherwise>
                                                </c:choose>
                                      </li>
                                  </c:if>
                              </c:forEach>
                          </ul>
                          
                          <!-- 댓글이 6개 이상일 경우에만 페이징 표시 -->
                          <c:if test="${totalComments > 5}">
                              <nav aria-label="댓글 페이지 네비게이션">
                                  <ul class="pagination pagination-sm justify-content-center">
                                      <!-- 이전 페이지 버튼 -->
                                      <li class="page-item ${currentCommentPage <= 1 ? 'disabled' : ''}">
                                          <a class="page-link" href="BoardViewAction.do?num=${board.num}&pageNum=${page}&commentPage=${currentCommentPage - 1}" 
                                             aria-label="이전">
                                              <span aria-hidden="true">&laquo;</span>
                                          </a>
                                      </li>
                                      
                                      <!-- 페이지 번호 -->
                                      <c:forEach var="i" begin="1" end="${totalPages}">
                                          <li class="page-item ${currentCommentPage == i ? 'active' : ''}">
                                              <a class="page-link" href="BoardViewAction.do?num=${board.num}&pageNum=${page}&commentPage=${i}">
                                                  ${i}
                                              </a>
                                          </li>
                                      </c:forEach>
                                      
                                      <!-- 다음 페이지 버튼 -->
                                      <li class="page-item ${currentCommentPage >= totalPages ? 'disabled' : ''}">
                                          <a class="page-link" href="BoardViewAction.do?num=${board.num}&pageNum=${page}&commentPage=${currentCommentPage + 1}" 
                                             aria-label="다음">
                                              <span aria-hidden="true">&raquo;</span>
                                          </a>
                                      </li>
                                  </ul>
                              </nav>
                          </c:if>
                      </c:if>
                  
                      <c:if test="${not empty sessionId}">
                          <form action="CommentWriteAction.do" method="post" class="mt-3">
                              <input type="hidden" name="boardNum" value="${board.num}">
                              <input type="hidden" name="pageNum" value="${page}">
                              <input type="hidden" name="commentPage" value="${param.commentPage != null ? param.commentPage : 1}">
                              <div class="mb-2">
                                  <textarea name="content" class="form-control" rows="3" placeholder="댓글을 입력하세요." required></textarea>
                              </div>
                              <button type="submit" class="btn btn-primary btn-sm">댓글 등록</button>
                          </form>
                      </c:if>
                  </div>
    
                    <!-- 하단 버튼 -->
                    <div class="d-flex justify-content-between">
                        <a href="BoardListAction.do?pageNum=${page}&category=${board.category}" class="btn btn-secondary">목록</a>
                        <c:if test="${not empty sessionId}">
                            <a href="BoardWriteForm.do?category=${board.category}" class="btn btn-primary">새로 글쓰기</a>
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
