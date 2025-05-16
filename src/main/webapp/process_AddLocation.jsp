<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="jakarta.servlet.http.Part" %>
<%@ page import="java.io.File" %>
<%@ page import="java.nio.file.Paths" %>
<%@ include file="dbconn.jsp" %>
<%
System.out.println("✔ process_AddLocation.jsp 실행됨");

request.setCharacterEncoding("UTF-8");
String table = request.getParameter("table");
System.out.println("✔ table 파라미터: " + table);

String uploadPath = application.getRealPath("/resources/img");

try {
    if ("city".equals(table)) {
        System.out.println("✔ if문 진입: city");

        int city_num = Integer.parseInt(request.getParameter("num"));
        String title = request.getParameter("title");
        String note = request.getParameter("note");
        String tag1 = request.getParameter("tag1");
        String tag2 = request.getParameter("tag2");
        String tag3 = request.getParameter("tag3");

        Part imagePart = request.getPart("image_file");
        String imageFile = Paths.get(imagePart.getSubmittedFileName()).getFileName().toString();
        if (imageFile != null && !imageFile.isEmpty()) {
            imagePart.write(uploadPath + File.separator + imageFile);
        }

        System.out.println("▶ city INSERT 값 확인");
        System.out.println(" - city_num: " + city_num);
        System.out.println(" - title: " + title);
        System.out.println(" - note: " + note);
        System.out.println(" - imageFile: " + imageFile);
        System.out.println(" - tag1: " + tag1 + ", tag2: " + tag2 + ", tag3: " + tag3);

        PreparedStatement pstmt = conn.prepareStatement(
            "INSERT INTO city (city_num, title, note, img, tag1, tag2, tag3) VALUES (?, ?, ?, ?, ?, ?, ?)");
        pstmt.setInt(1, city_num);
        pstmt.setString(2, title);
        pstmt.setString(3, note);
        pstmt.setString(4, imageFile);
        pstmt.setString(5, tag1);
        pstmt.setString(6, tag2);
        pstmt.setString(7, tag3);
        int result = pstmt.executeUpdate();
        System.out.println("▶ city INSERT 결과: " + result);

    } else if ("city_district".equals(table)) {
        System.out.println("✔ if문 진입: city_district");

        int d_city_num = Integer.parseInt(request.getParameter("city_num"));
        String d_title = request.getParameter("title");
        String d_note = request.getParameter("note");
        String d_tag1 = request.getParameter("tag1");
        String d_tag2 = request.getParameter("tag2");
        String d_tag3 = request.getParameter("tag3");

        Part mainImg = request.getPart("img_file");
        String mainFile = Paths.get(mainImg.getSubmittedFileName()).getFileName().toString();
        if (mainFile != null && !mainFile.isEmpty()) {
            mainImg.write(uploadPath + File.separator + mainFile);
        }

        Part tag1Img = request.getPart("tag1_img_file");
        String tag1File = Paths.get(tag1Img.getSubmittedFileName()).getFileName().toString();
        if (tag1File != null && !tag1File.isEmpty()) {
            tag1Img.write(uploadPath + File.separator + tag1File);
        }

        Part tag2Img = request.getPart("tag2_img_file");
        String tag2File = Paths.get(tag2Img.getSubmittedFileName()).getFileName().toString();
        if (tag2File != null && !tag2File.isEmpty()) {
            tag2Img.write(uploadPath + File.separator + tag2File);
        }

        Part tag3Img = request.getPart("tag3_img_file");
        String tag3File = Paths.get(tag3Img.getSubmittedFileName()).getFileName().toString();
        if (tag3File != null && !tag3File.isEmpty()) {
            tag3Img.write(uploadPath + File.separator + tag3File);
        }

        System.out.println("▶ city_district INSERT 값 확인");
        System.out.println(" - d_city_num: " + d_city_num);
        System.out.println(" - d_title: " + d_title);
        System.out.println(" - d_note: " + d_note);
        System.out.println(" - mainFile: " + mainFile);
        System.out.println(" - tag1: " + d_tag1 + "/" + tag1File);
        System.out.println(" - tag2: " + d_tag2 + "/" + tag2File);
        System.out.println(" - tag3: " + d_tag3 + "/" + tag3File);

        PreparedStatement pstmt = conn.prepareStatement(
            "INSERT INTO city_district (d_city_num, d_title, d_note, d_img, d_tag1, d_tag1_img, d_tag2, d_tag2_img, d_tag3, d_tag3_img) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
        pstmt.setInt(1, d_city_num);
        pstmt.setString(2, d_title);
        pstmt.setString(3, d_note);
        pstmt.setString(4, mainFile);
        pstmt.setString(5, d_tag1);
        pstmt.setString(6, tag1File);
        pstmt.setString(7, d_tag2);
        pstmt.setString(8, tag2File);
        pstmt.setString(9, d_tag3);
        pstmt.setString(10, tag3File);
        int result = pstmt.executeUpdate();
        System.out.println("▶ city_district INSERT 결과: " + result);
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>등록 결과</title>
    <link href="./resources/css/bootstrap.min.css" rel="stylesheet">
    <script src="./resources/js/bootstrap.bundle.min.js"></script>
</head>
<body>
    <!-- 등록 성공 모달 -->
    <div class="modal fade" id="successModal" tabindex="-1" aria-labelledby="successLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="successLabel">등록 완료</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="닫기"></button>
                </div>
                <div class="modal-body">
                    등록이 완료되었습니다.
                </div>
                <div class="modal-footer border-0">
                    <button type="button" class="btn btn-primary" onclick="location.href='AddLocation.jsp'">확인</button>
                </div>
            </div>
        </div>
    </div>

    <script>
        window.addEventListener("DOMContentLoaded", function () {
            const modal = new bootstrap.Modal(document.getElementById("successModal"));
            modal.show();
        });
    </script>
</body>
</html>
<%
} catch (Exception ex) {
    ex.printStackTrace();
    System.out.println("▶ 오류: " + ex.getMessage());

    String errorType = ex.getClass().getSimpleName();
    String errorMsg = ex.getMessage() != null ? ex.getMessage().replace("'", "") : "오류 메시지 없음";
%>
    <script>
      alert("오류 발생: <%= errorType %>: <%= errorMsg %>");
      history.back();
    </script>
<%
}
%>
