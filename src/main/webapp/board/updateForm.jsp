<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
   String id = (String) request.getAttribute("id");
   mvc.model.BoardDTO board = (mvc.model.BoardDTO) request.getAttribute("board");
   int num = ((Integer) request.getAttribute("num")).intValue();
   int nowpage = ((Integer) request.getAttribute("page")).intValue();
%>
<html>
<head>
<link rel="stylesheet" href="./resources/css/styles.css">
<link rel="stylesheet" href="./resources/css/bootstrap.min.css" />

<script type="text/javascript">
   function checkForm() {
      if (!document.updateWrite.subject.value) {
         alert("제목을 입력하세요.");
         return false;
      }
      if (!document.updateWrite.content.value) {
         alert("내용을 입력하세요.");
         return false;
      }      
      return true;
   }
</script>
<title>게시글 수정</title>
</head>

<body>
    <jsp:include page="../header.jsp" />

    <div class="main-container">
        <div class="content-wrap board-write py-5" style="margin-top: 80px;">
            <div class="container">
                <h2 class="mb-4">✏️ 게시글 수정</h2>

                <form name="updateWrite" action="./BoardUpdateAction.do" method="post" enctype="multipart/form-data" onsubmit="return checkForm()">
                    <!-- 서버에 전달할 hidden 필드들 -->
                    <input type="hidden" name="id" id="id" value="<%=id%>">
					<input type="hidden" name="num" id="num" value="<%=num%>">
					<input type="hidden" name="pageNum" id="pageNum" value="<%=nowpage%>">


                    <div class="mb-3 row">
                        <label class="col-sm-2 col-form-label">제목</label>
                        <div class="col-sm-6">
                            <input name="subject" type="text" class="form-control" value="<%=board.getSubject()%>" required>
                        </div>
                    </div>

                    <div class="mb-3 row">
                        <label class="col-sm-2 col-form-label">내용</label>
                        <div class="col-sm-8">
                            <textarea name="content" rows="6" class="form-control" required><%=board.getContent()%></textarea>
                        </div>
                    </div>
                    
                    <!-- 첨부파일 필드를 추가 (기존 updateForm.jsp에 아래 내용 삽입) -->
					<div class="mb-3 row">
					    <label class="col-sm-2 col-form-label">첨부파일</label>
					    <div class="col-sm-8">
					        <c:choose>
					            <c:when test="${not empty board.fileName}">
					                <div class="mb-2">
					                    <span>현재 파일: ${board.originalFileName} (${board.fileSize / 1024}KB)</span>
					                    <div class="form-check mt-1">
					                        <input class="form-check-input" type="checkbox" name="deleteFile" id="deleteFile" value="1">
					                        <label class="form-check-label" for="deleteFile">파일 삭제</label>
					                    </div>
					                </div>
					            </c:when>
					        </c:choose>
					        <input type="file" name="attachment" class="form-control">
					        <small class="form-text text-muted">새 파일을 선택하면 기존 파일은 대체됩니다.</small>
					    </div>
					</div>

                    <div class="mb-3 row">
                        <div class="offset-sm-2 col-sm-10">
                            <input type="submit" class="btn btn-primary me-2" value="수정 완료">
                            <a href="./BoardViewAction.do?num=<%=num%>&pageNum=<%=nowpage%>" class="btn btn-secondary">취소</a>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <jsp:include page="../footer.jsp" />
</body>
</html>