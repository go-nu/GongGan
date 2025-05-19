<%@ page import="java.sql.*" %>
<%@ include file="dbconn.jsp" %>
<%
request.setCharacterEncoding("UTF-8");

String table = request.getParameter("table");
System.out.println("테이블 타입: " + table);

PreparedStatement pstmt = null;

try {
    if ("city".equals(table)) {
        String city_num = request.getParameter("city_num");
        String title = request.getParameter("title");
        String note = request.getParameter("note");
        String tag1 = request.getParameter("tag1");
        String tag2 = request.getParameter("tag2");
        String tag3 = request.getParameter("tag3");
        String img = request.getParameter("img");

        System.out.println("도시 img 값: " + img);

        pstmt = conn.prepareStatement(
            "INSERT INTO city (city_num, title, note, tag1, tag2, tag3, img) VALUES (?, ?, ?, ?, ?, ?, ?)"
        );
        pstmt.setInt(1, Integer.parseInt(city_num));
        pstmt.setString(2, title);
        pstmt.setString(3, note);
        pstmt.setString(4, tag1);
        pstmt.setString(5, tag2);
        pstmt.setString(6, tag3);
        pstmt.setString(7, img);
        pstmt.executeUpdate();

    } else if ("city_district".equals(table)) {
        String d_city_num = request.getParameter("d_city_num");
        String d_title = request.getParameter("d_title");
        String d_note = request.getParameter("d_note");
        String d_tag1 = request.getParameter("d_tag1");
        String d_tag2 = request.getParameter("d_tag2");
        String d_tag3 = request.getParameter("d_tag3");
        String d_img = request.getParameter("d_img");
        String d_tag1_img = request.getParameter("d_tag1_img");
        String d_tag2_img = request.getParameter("d_tag2_img");
        String d_tag3_img = request.getParameter("d_tag3_img");

        pstmt = conn.prepareStatement(
            "INSERT INTO city_district (d_city_num, d_title, d_note, d_tag1, d_tag2, d_tag3, d_img, d_tag1_img, d_tag2_img, d_tag3_img) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"
        );
        pstmt.setInt(1, Integer.parseInt(d_city_num));
        pstmt.setString(2, d_title);
        pstmt.setString(3, d_note);
        pstmt.setString(4, d_tag1);
        pstmt.setString(5, d_tag2);
        pstmt.setString(6, d_tag3);
        pstmt.setString(7, d_img);
        pstmt.setString(8, d_tag1_img);
        pstmt.setString(9, d_tag2_img);
        pstmt.setString(10, d_tag3_img);
        pstmt.executeUpdate();
    }

    response.sendRedirect("AddLocation.jsp");

} catch (Exception e) {
    e.printStackTrace();
    out.println("<script>alert('등록 중 오류가 발생했습니다.'); history.back();</script>");
} finally {
    if (pstmt != null) try { pstmt.close(); } catch (Exception ignore) {}
}
%>
