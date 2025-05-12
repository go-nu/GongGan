<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*" %>
<%
    request.setCharacterEncoding("UTF-8");
    String editedHtml = request.getParameter("editedHtml");
    String filePath = application.getRealPath("mainContent.html");

    try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath))) {
        writer.write(editedHtml);
    } catch (IOException e) {
        out.println("파일 저장 오류: " + e.getMessage());
    }

    // 수정 후 원래 페이지로 이동
    response.sendRedirect("main.jsp");
%>