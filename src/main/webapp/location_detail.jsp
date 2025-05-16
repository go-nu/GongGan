<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ include file="dbconn.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <title>지역 상세 페이지</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/index_style.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <script src="<%= request.getContextPath() %>/resources/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/location_detail_style.css">
</head>
<body>
<%@ include file="header.jsp"%>

<%
PreparedStatement pstmt = null;
ResultSet rs = null;
String cityIdStr = request.getParameter("city_num"); // 파라미터명 변경
int cityId = 0;
int cityCode = 0;

if (cityIdStr != null) {
    try {
        cityId = Integer.parseInt(cityIdStr);

        String sql = "SELECT * FROM city WHERE city_num = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, cityId);
        rs = pstmt.executeQuery();
%>

<div class="container py-5 mt-5">
    <div class="main-section mt-5 mb-4 px-5">
        <% if (rs.next()) {
            cityCode = rs.getInt("city_num");
        %>
        <!-- 왼쪽 이미지 -->
        <div class="left-image mb-4 mb-md-0">
            <img src="<%= request.getContextPath() %>/resources/img/<%= rs.getString("img") %>" alt="<%= rs.getString("title") %>" class="main-image img-fluid text-center">
        </div>

        <!-- 오른쪽 정보 -->
        <div class="right-info" style="min-height: 300px;">
            <h1 class="pb-3"><b><%= rs.getString("title") %></b></h1>
            <p><%= rs.getString("note") %></p>

            <div class="bottom-box mt-auto">
                <div class="place-info mt-4">
                    <p><strong>주요 명소 1:</strong> <%= rs.getString("tag1") %></p>
                    <p><strong>주요 명소 2:</strong> <%= rs.getString("tag2") %></p>
                    <div class="d-flex justify-content-between align-items-center">
                        <p class="m-0"><strong>주요 명소 3:</strong> <%= rs.getString("tag3") %></p>
                        <button class="btn btn-outline-secondary btn-sm" onclick="history.back()">뒤로가기</button>
                    </div>
                </div>
            </div>
        </div>
        <% } %>
    </div>
</div>
<%
    } catch (SQLException e) {
        out.println("<p style='color:red;'>오류 발생: " + e.getMessage() + "</p>");
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) {}
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) {}
    }
}
%>

<%
PreparedStatement pstmt2 = null;
ResultSet rs2 = null;

if (cityCode > 0) {
    try {
        String sql2 = "SELECT * FROM city_district WHERE d_city_num = ?";
        pstmt2 = conn.prepareStatement(sql2);
        pstmt2.setInt(1, cityCode);
        rs2 = pstmt2.executeQuery();
%>

<section class="about-section" style="padding: 60px 0;">
  <div class="container">
    <% while (rs2.next()) { %>
    <div class="main-section mt-5 mb-4 px-5">
        <div class="left-image mb-4 mb-md-0">
            <img src="<%= request.getContextPath() %>/resources/img/<%= rs2.getString("d_img") %>" alt="<%= rs2.getString("d_title") %>" class="main-image img-fluid text-center">
        </div>

        <div class="right-info" style="position: relative; min-height: 300px;">
            <h2 class="pb-2"><b><%= rs2.getString("d_title") %></b></h2>
            <p><%= rs2.getString("d_note") %></p>

            <div class="row mt-4">
              <div class="col-md-4">
                <img src="<%= request.getContextPath() %>/resources/img/<%= rs2.getString("d_tag1_img") %>" class="slide-thumbnail mb-1" alt="명소1">
                <h4 class="text-center" style="font-size: 1rem;"><%= rs2.getString("d_tag1") %></h4>
              </div>
              <div class="col-md-4">
                <img src="<%= request.getContextPath() %>/resources/img/<%= rs2.getString("d_tag2_img") %>" class="slide-thumbnail mb-1" alt="명소2">
                <h4 class="text-center" style="font-size: 1rem;"><%= rs2.getString("d_tag2") %></h4>
              </div>
              <div class="col-md-4">
                <img src="<%= request.getContextPath() %>/resources/img/<%= rs2.getString("d_tag3_img") %>" class="slide-thumbnail mb-1" alt="명소3">
                <h4 class="text-center" style="font-size: 1rem;"><%= rs2.getString("d_tag3") %></h4>
              </div>
            </div>
        </div>
    </div>
    <% } %>
  </div>
</section>
<%
    } catch (SQLException e) {
        out.println("<p style='color:red;'>city_district 출력 오류: " + e.getMessage() + "</p>");
    } finally {
        if (rs2 != null) try { rs2.close(); } catch (SQLException e) {}
        if (pstmt2 != null) try { pstmt2.close(); } catch (SQLException e) {}
    }
}
%>

<section class="class-section" style="min-height: 160px;">
    <div class="container"></div>
</section>

<%@ include file="footer.jsp" %>
</body>
</html>
