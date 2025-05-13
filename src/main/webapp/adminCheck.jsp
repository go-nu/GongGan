<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    if (request.isUserInRole("admin")) {
        response.sendRedirect(request.getContextPath() + "/index.jsp");
    } else {
        response.sendRedirect("loginError.jsp");
    }
%>