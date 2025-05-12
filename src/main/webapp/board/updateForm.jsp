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

                <form name="updateWrite" action="./BoardUpdateAction.do" method="post" onsubmit="return checkForm()">
                    <!-- 서버에 전달할 hidden 필드들 -->
                    <input type="hidden" name="id" value="<%=id%>">
                    <input type="hidden" name="num" value="<%=num%>">
                    <input type="hidden" name="pageNum" value="<%=nowpage%>">

                    <!-- 사용자에게 보여줄 ID -->
                    <div class="mb-3 row">
                        <label class="col-sm-2 col-form-label">아이디</label>
                        <div class="col-sm-4">
                            <input type="text" class="form-control" value="<%=id%>" readonly>
                        </div>
                    </div>

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