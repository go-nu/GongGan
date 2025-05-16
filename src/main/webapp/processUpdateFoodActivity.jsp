<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, java.io.*, java.util.*" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ include file="dbconn.jsp" %>

<%

    String savePath = application.getRealPath("/resources/img");  // 업로드 디렉토리
    int maxSize = 10 * 1024 * 1024; // 최대 10MB
    String encoding = "UTF-8";

    MultipartRequest multi = new MultipartRequest(
        request,
        savePath,
        maxSize,
        encoding,
        new DefaultFileRenamePolicy()
    );

    String actId     = multi.getParameter("ACT_ID");
    String title     = multi.getParameter("TITLE");
    int price        = Integer.parseInt(multi.getParameter("PRICE"));
    int maxCount     = Integer.parseInt(multi.getParameter("MAX_COUNT"));
    String actDate   = multi.getParameter("ACT_DATE");
    String address   = multi.getParameter("ADDRESS");
    String note      = multi.getParameter("NOTE");

    String oldImg    = multi.getParameter("oldImg");
    String newImg    = multi.getFilesystemName("image_file_upload");

    String finalImg = (newImg != null) ? newImg : oldImg;

    String sql = "UPDATE fs_semi.activity SET TITLE=?, PRICE=?, IMG=?, MAX_COUNT=?, ACT_DATE=?, ADDRESS=?, NOTE=? WHERE ACT_ID=?";

    PreparedStatement pstmt = conn.prepareStatement(sql);
    pstmt.setString(1, title);
    pstmt.setInt(2, price);
    pstmt.setString(3, finalImg);
    pstmt.setInt(4, maxCount);
    pstmt.setString(5, actDate);
    pstmt.setString(6, address);
    pstmt.setString(7, note);
    pstmt.setString(8, actId);

    int result = pstmt.executeUpdate();

    pstmt.close();
    conn.close();

	String returnURL = multi.getParameter("returnURL");
	if (returnURL == null || returnURL.trim().equals("")) {
	    returnURL = "admin_FoodActivity.jsp";  // 기본 경로
	}
    if (result > 0) {
    	%>
    	<script>
    	    alert("수정이 완료되었습니다.");
    	    location.href = "<%= returnURL %>";
    	</script>
    	<%
    } else {
        out.println("<script>alert('수정 실패'); history.back();</script>");
    }
%>
