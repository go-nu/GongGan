<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.*"%>
<%@ page import="java.nio.file.*"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ include file="dbconn.jsp"%>

<%
String savePath = application.getRealPath("/resources/img");
int maxSize = 20 * 1024 * 1024; // 20MB
String encoding = "UTF-8";

MultipartRequest multi = new MultipartRequest(request, savePath, maxSize, encoding, null);

// 폼에서 전송된 텍스트 데이터 가져오기
String filename = multi.getParameter("filename"); // 기존 파일명 (hidden 필드로 전달)
String title = multi.getParameter("title");
String note = multi.getParameter("note");
String tag1 = multi.getParameter("tag1");
String tag2 = multi.getParameter("tag2");
String tag3 = multi.getParameter("tag3");
String tag4 = multi.getParameter("tag4");
String tag5 = multi.getParameter("tag5");

if (tag1.equalsIgnoreCase("null")) {
	tag1 = null;
}
if (tag2.equalsIgnoreCase("null")) {
	tag2 = null;
}
if (tag3.equalsIgnoreCase("null")) {
	tag3 = null;
}
if (tag4.equalsIgnoreCase("null")) {
	tag4 = null;
}
if (tag5.equalsIgnoreCase("null")) {
	tag5 = null;
}

// DB 연결 및 업데이트 처리
PreparedStatement stmt = null;
String newFilename = filename; // 기존 파일명 사용

if (conn == null) {
	out.println("<script>alert('DB 연결 실패!'); window.location.href = 'editPage.jsp';</script>");
	return;
}

try {
	// 업로드된 파일이 있을 경우 기존 파일 이름을 그대로 사용
	File uploadedFile = multi.getFile("newfilename"); // "file"은 HTML 폼에서 파일 입력 필드의 name 속성

	if (uploadedFile != null) {
		// 기존 파일 이름으로 저장
		File targetFile = new File(savePath + File.separator + filename);

		// 기존 파일이 있으면 삭제
		if (targetFile.exists()) {
	targetFile.delete(); // 기존 파일 삭제
		}

		// 업로드된 파일을 기존 이름으로 저장
		if (!uploadedFile.renameTo(targetFile)) {
	out.println("<script>alert('파일 저장에 실패했습니다.'); window.location.href = 'editPage.jsp';</script>");
	return;
		}
	}
	// DB 업데이트 쿼리 작성
	String sql = "UPDATE main SET TITLE = ?, NOTE = ?, TAG1 = ?, TAG2 = ?, TAG3 = ?, TAG4 = ?, TAG5 = ?, FILENAME = ? WHERE FILENAME = ?";
	stmt = conn.prepareStatement(sql);

	stmt.setString(1, title);
	stmt.setString(2, note);
	stmt.setString(3, tag1);
	stmt.setString(4, tag2);
	stmt.setString(5, tag3);
	stmt.setString(6, tag4);
	stmt.setString(7, tag5);
	stmt.setString(8, newFilename); // 새 파일 이름 (기존 파일명 사용)
	stmt.setString(9, filename); // 기존 파일 이름 (hidden 필드)

	// 업데이트 실행
	int rowsUpdated = stmt.executeUpdate();

	if (rowsUpdated > 0) {
		out.println("<script>alert('슬라이드 정보가 성공적으로 수정되었습니다.'); window.location.href = 'index.jsp';</script>");
	} else {
		out.println("<script>alert('수정 실패. 해당 파일을 찾을 수 없습니다.'); window.location.href = 'editPage.jsp';</script>");
	}
} catch (SQLException e) {
	e.printStackTrace();
	out.println("<script>alert('오류 발생: " + e.getMessage() + "'); window.location.href = 'editPage.jsp';</script>");
} catch (IOException e) {
	e.printStackTrace();
	out.println("<script>alert('파일 처리 오류: " + e.getMessage() + "'); window.location.href = 'editPage.jsp';</script>");
} finally {
	try {
		if (stmt != null)
	stmt.close();
		if (conn != null)
	conn.close();
	} catch (SQLException e) {
		e.printStackTrace();
	}
}
%>
