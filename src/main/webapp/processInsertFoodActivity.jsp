<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, java.io.*, java.util.*" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ include file="dbconn.jsp" %>

<%
    String savePath = application.getRealPath("/resources/img");
    int maxSize = 10 * 1024 * 1024;
    MultipartRequest multi = new MultipartRequest(request, savePath, maxSize, "UTF-8", new DefaultFileRenamePolicy());

    // 필드값 가져오기
    String title     = multi.getParameter("TITLE");
    int price        = Integer.parseInt(multi.getParameter("PRICE"));
    String img       = multi.getFilesystemName("image_file_upload");
    int maxCount     = Integer.parseInt(multi.getParameter("MAX_COUNT"));
    String actDate   = multi.getParameter("ACT_DATE");
    String address   = multi.getParameter("ADDRESS");
    String note      = multi.getParameter("NOTE");

    // ACT_ID 생성 (랜덤 8자리 영숫자)
    String actId = "A" + UUID.randomUUID().toString().replaceAll("-", "").substring(0, 7).toUpperCase();

    String sql = "INSERT INTO fs_semi.activity (ACT_ID, TITLE, PRICE, IMG, MAX_COUNT, ACT_DATE, ADDRESS, NOTE) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
    PreparedStatement pstmt = conn.prepareStatement(sql);
    pstmt.setString(1, actId);
    pstmt.setString(2, title);
    pstmt.setInt(3, price);
    pstmt.setString(4, img);
    pstmt.setInt(5, maxCount);
    pstmt.setString(6, actDate);
    pstmt.setString(7, address);
    pstmt.setString(8, note);

    int result = pstmt.executeUpdate();
    pstmt.close();
    conn.close();

    if (result > 0) {
    	%>
    	<script>
    	    alert("등록이 완료되었습니다.");
    	    location.href = "admin_FoodActivity.jsp";
    	</script>
    	<%
    } else {
        out.println("<script>alert('등록 실패'); history.back();</script>");
    }
%>
