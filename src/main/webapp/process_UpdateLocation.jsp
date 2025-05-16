<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.io.*, jakarta.servlet.http.Part, java.nio.file.Paths" %>
<%@ include file="dbconn.jsp" %>
<%
request.setCharacterEncoding("UTF-8");

String table = request.getParameter("table");
String id = request.getParameter("id");
String title = request.getParameter("title");
String note = request.getParameter("note");
String tag1 = request.getParameter("tag1");
String tag2 = request.getParameter("tag2");
String tag3 = request.getParameter("tag3");

String uploadPath = application.getRealPath("/resources/img");
boolean success = false;

try {
    if ("city".equals(table)) {
        // 기존 이미지 가져오기
        String imageFile = "";
        PreparedStatement imgStmt = conn.prepareStatement("SELECT img FROM city WHERE city_num = ?");
        imgStmt.setInt(1, Integer.parseInt(id));
        ResultSet imgRs = imgStmt.executeQuery();
        if (imgRs.next()) {
            imageFile = imgRs.getString("img");
        }

        // 새 이미지가 있다면 덮어씀
        Part imgPart = request.getPart("image_file");
        String newImg = Paths.get(imgPart.getSubmittedFileName()).getFileName().toString();
        if (newImg != null && !newImg.isEmpty()) {
            imageFile = newImg;
            imgPart.write(uploadPath + File.separator + imageFile);
        }

        PreparedStatement pstmt = conn.prepareStatement(
            "UPDATE city SET title=?, note=?, tag1=?, tag2=?, tag3=?, img=? WHERE city_num=?");
        pstmt.setString(1, title);
        pstmt.setString(2, note);
        pstmt.setString(3, tag1);
        pstmt.setString(4, tag2);
        pstmt.setString(5, tag3);
        pstmt.setString(6, imageFile);
        pstmt.setInt(7, Integer.parseInt(id));
        pstmt.executeUpdate();
        success = true;
    } else if ("city_district".equals(table)) {
        String[] tagImgs = new String[3];
        String mainImg = "";

        // 기존 이미지들 먼저 가져오기
        PreparedStatement imgStmt = conn.prepareStatement(
            "SELECT d_img, d_tag1_img, d_tag2_img, d_tag3_img FROM city_district WHERE id=?");
        imgStmt.setInt(1, Integer.parseInt(id));
        ResultSet imgRs = imgStmt.executeQuery();
        if (imgRs.next()) {
            mainImg = imgRs.getString("d_img");
            tagImgs[0] = imgRs.getString("d_tag1_img");
            tagImgs[1] = imgRs.getString("d_tag2_img");
            tagImgs[2] = imgRs.getString("d_tag3_img");
        }

        // 메인 이미지 수정
        Part mainPart = request.getPart("image_file");
        String newMain = Paths.get(mainPart.getSubmittedFileName()).getFileName().toString();
        if (newMain != null && !newMain.isEmpty()) {
            mainImg = newMain;
            mainPart.write(uploadPath + File.separator + mainImg);
        }

        // 태그 이미지 수정
        for (int i = 1; i <= 3; i++) {
            Part tagPart = request.getPart("tag" + i + "_img_file");
            String newTag = Paths.get(tagPart.getSubmittedFileName()).getFileName().toString();
            if (newTag != null && !newTag.isEmpty()) {
                tagImgs[i - 1] = newTag;
                tagPart.write(uploadPath + File.separator + newTag);
            }
        }

        PreparedStatement pstmt = conn.prepareStatement(
            "UPDATE city_district SET d_title=?, d_note=?, d_tag1=?, d_tag1_img=?, d_tag2=?, d_tag2_img=?, d_tag3=?, d_tag3_img=?, d_img=? WHERE id=?");
        pstmt.setString(1, title);
        pstmt.setString(2, note);
        pstmt.setString(3, tag1);
        pstmt.setString(4, tagImgs[0]);
        pstmt.setString(5, tag2);
        pstmt.setString(6, tagImgs[1]);
        pstmt.setString(7, tag3);
        pstmt.setString(8, tagImgs[2]);
        pstmt.setString(9, mainImg);
        pstmt.setInt(10, Integer.parseInt(id));
        pstmt.executeUpdate();
        success = true;
    }
} catch (Exception e) {
    e.printStackTrace();
%>
    <script>
        alert("오류 발생: <%= e.getMessage().replaceAll("'", "") %>");
        history.back();
    </script>
<%
}
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>수정 완료</title>
    <link href="./resources/css/bootstrap.min.css" rel="stylesheet">
    <script src="./resources/js/bootstrap.bundle.min.js"></script>
</head>
<body>
    <!-- 수정 완료 모달 -->
    <div class="modal fade" id="updateSuccessModal" tabindex="-1" aria-labelledby="updateSuccessLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="updateSuccessLabel">수정 완료</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="닫기"></button>
                </div>
                <div class="modal-body">
                    수정이 완료되었습니다.
                </div>
                <div class="modal-footer border-0">
                    <button type="button" class="btn btn-primary" onclick="redirect()">확인</button>
                </div>
            </div>
        </div>
    </div>

    <script>
        function redirect() {
            location.href = "ManageLocation.jsp?table=<%=table%>&id=<%=id%>";
        }

        window.addEventListener("DOMContentLoaded", function () {
            const modal = new bootstrap.Modal(document.getElementById("updateSuccessModal"));
            modal.show();
        });
    </script>
</body>
</html>