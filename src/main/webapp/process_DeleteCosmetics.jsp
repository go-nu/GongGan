<%@ page import="dao.CosmeticsRepository" %>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    CosmeticsRepository repo = CosmeticsRepository.getInstance();
    repo.deleteCosmetic(id);
    response.sendRedirect("beautyList.jsp");
%>
