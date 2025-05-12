<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*" %>
<%
    request.setCharacterEncoding("UTF-8");
    String targetPage = request.getParameter("page");

    if (targetPage == null || targetPage.trim().isEmpty()) {
        out.println("수정할 페이지가 지정되지 않았습니다.");
        return;
    }

    String filePath = application.getRealPath(targetPage);
    StringBuilder content = new StringBuilder();

    try (BufferedReader reader = new BufferedReader(new FileReader(filePath))) {
        String line;
        while ((line = reader.readLine()) != null) {
            content.append(line).append("\n");
        }
    } catch (IOException e) {
        out.println("파일 읽기 오류: " + e.getMessage());
        return;
    }
%>

<form method="post" action="saveEdit.jsp">
    <input type="hidden" name="page" value="<%= targetPage %>">
    <textarea name="editedHtml" style="width: 100%; height: 600px;"><%= content.toString() %></textarea>
    <br>
    <input type="submit" value="적용">
</form>