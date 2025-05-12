<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
   String id = (String) request.getAttribute("id");
   
%>
<html>
<head>
<link rel="stylesheet" href="./resources/css/styles.css">
<link rel="stylesheet" href="./resources/css/bootstrap.min.css" />

<script type="text/javascript">
   function checkForm() {
      if (!document.newWrite.subject.value) {
         alert("제목을 입력하세요.");
         return false;
      }
      if (!document.newWrite.content.value) {
         alert("내용을 입력하세요.");
         return false;
      }      
      return true;
   }
</script>
<title>Board</title>
</head>

<body>
    <jsp:include page="../header.jsp" />

    <div class="main-container">
        <div class="content-wrap board-write py-5" style="margin-top: 80px;">
            <div class="container">
                <h2 class="mb-4">📝 글쓰기</h2>

                <form name="newWrite" action="./BoardWriteAction.do" method="post" onsubmit="return checkForm()">
                    <!-- 서버에 전달할 사용자 ID (숨김) -->
                    <input type="hidden" name="id" value="<%=id%>">

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
                            <input name="subject" type="text" class="form-control" placeholder="제목을 입력하세요." required>
                        </div>
                    </div>

                    <div class="mb-3 row">
                        <label class="col-sm-2 col-form-label">내용</label>
                        <div class="col-sm-8">
                            <textarea name="content" rows="6" class="form-control" placeholder="내용을 입력하세요." required></textarea>
                        </div>
                    </div>

                    <div class="mb-3 row">
                        <div class="offset-sm-2 col-sm-10">
                            <input type="submit" class="btn btn-primary me-2" value="등록">
                            <input type="reset" class="btn btn-secondary" value="취소">
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <jsp:include page="../footer.jsp" />
</body>


</html>

