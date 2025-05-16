<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ include file="dbconn.jsp" %>
<%
    request.setCharacterEncoding("UTF-8");

    String sessionId = (String) session.getAttribute("id");
    String name = request.getParameter("name");
    String gender = request.getParameter("gender");
    String birth = request.getParameter("birth");
    String email = request.getParameter("email");
    String phone = request.getParameter("phone");
    String address = request.getParameter("address");
    String password = request.getParameter("password");
    String confirmPassword = request.getParameter("confirmPassword");

    String message = "";
    String redirectURL = "";
    boolean showModal = true;
    boolean isError = false;

    String newPassword = null;
    boolean changePassword = false;

    if (password != null && !password.trim().isEmpty()) {
        if (password.equals(confirmPassword)) {
            newPassword = password;
            changePassword = true;
        } else {
            message = "비밀번호와 비밀번호 확인이 일치하지 않습니다.";
            isError = true;
        }
    }

    if (!isError) {
        PreparedStatement pstmt = null;
        try {
            if (changePassword) {
                String sql = "UPDATE users SET name=?, gender=?, birth=?, email=?, phone=?, address=?, password=? WHERE id=?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, name);
                pstmt.setString(2, gender);
                pstmt.setString(3, birth);
                pstmt.setString(4, email);
                pstmt.setString(5, phone);
                pstmt.setString(6, address);
                pstmt.setString(7, newPassword);
                pstmt.setString(8, sessionId);
            } else {
                String sql = "UPDATE users SET name=?, gender=?, birth=?, email=?, phone=?, address=? WHERE id=?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, name);
                pstmt.setString(2, gender);
                pstmt.setString(3, birth);
                pstmt.setString(4, email);
                pstmt.setString(5, phone);
                pstmt.setString(6, address);
                pstmt.setString(7, sessionId);
            }

            int result = pstmt.executeUpdate();

            if (result > 0) {
                session.setAttribute("name", name);
                session.setAttribute("gender", gender);
                session.setAttribute("birth", birth);
                session.setAttribute("email", email);
                session.setAttribute("phone", phone);
                session.setAttribute("address", address);

                message = "정보가 성공적으로 수정되었습니다.";
                redirectURL = "MyPage.do";
            } else {
                message = "정보 수정에 실패했습니다.";
                isError = true;
            }
            pstmt.close();
        } catch (Exception e) {
            message = "오류 발생: " + e.getMessage().replace("'", "");
            isError = true;
        } finally {
            if (conn != null) conn.close();
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>정보 수정 결과</title>
    <link href="./resources/css/bootstrap.min.css" rel="stylesheet">
    <script src="./resources/js/bootstrap.bundle.min.js"></script>
</head>
<body>
    <!-- 결과 모달 -->
    <div class="modal fade" id="resultModal" tabindex="-1" aria-labelledby="resultModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="resultModalLabel"><%= isError ? "오류" : "성공" %></h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="닫기"></button>
                </div>
                <div class="modal-body">
                    <%= message %>
                </div>
                <div class="modal-footer border-0">
                    <% if (isError) { %>
                        <button type="button" class="btn btn-secondary" onclick="history.back()">확인</button>
                    <% } else { %>
                        <button type="button" class="btn btn-success" onclick="location.href='<%= redirectURL %>'">확인</button>
                    <% } %>
                </div>
            </div>
        </div>
    </div>

    <script>
        window.addEventListener("DOMContentLoaded", function () {
            var resultModal = new bootstrap.Modal(document.getElementById("resultModal"));
            resultModal.show();
        });
    </script>
</body>
</html>
