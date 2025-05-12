<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>K-Food Guide - 회원가입</title>
    <link rel="stylesheet" href="css/index_style.css">
    <style>
        .register-section {
            padding: 60px 0;
        }
        .register-container {
            max-width: 600px;
            margin: 0 auto;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            padding: 40px;
        }
        .register-header {
            text-align: center;
            margin-bottom: 30px;
        }
        .register-header h1 {
            color: #d32f2f;
            margin-bottom: 10px;
        }
        .register-form .form-group {
            margin-bottom: 20px;
        }
        .register-form label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
        }
        .register-form input[type="text"],
        .register-form input[type="password"],
        .register-form input[type="email"],
        .register-form input[type="tel"],
        .register-form input[type="date"],
        .register-form select,
        .register-form textarea {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 16px;
        }
        .register-form button {
            width: 100%;
            padding: 14px;
            background-color: #d32f2f;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        .register-form button:hover {
            background-color: #b71c1c;
        }
        .error-message {
            color: #d32f2f;
            text-align: center;
            margin-bottom: 20px;
        }
        .success-message {
            color: #4CAF50;
            text-align: center;
            margin-bottom: 20px;
        }
        .gender-options {
            display: flex;
            gap: 20px;
        }
        .gender-option {
            display: flex;
            align-items: center;
        }
        .gender-option input {
            margin-right: 8px;
        }
    </style>
</head>
<body>
    <%@ include file="header.jsp" %>
    
    <%
        // 회원가입 처리 코드
        String errorMessage = "";
        String successMessage = "";
        String id = "";
        String password = "";
        String confirmPassword = "";
        String name = "";
        String gender = "";
        String birth = "";
        String email = "";
        String phone = "";
        String address = "";
        boolean isRegistered = false;
        
        // 이미 로그인한 경우 메인 페이지로 리디렉션
        if (session.getAttribute("user") != null) {
            response.sendRedirect("index.jsp");
            return;
        }
        
        // 회원가입 처리
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            id = request.getParameter("id");
            password = request.getParameter("password");
            confirmPassword = request.getParameter("confirmPassword");
            name = request.getParameter("name");
            gender = request.getParameter("gender");
            birth = request.getParameter("birth");
            email = request.getParameter("email");
            phone = request.getParameter("phone");
            address = request.getParameter("address");
            
            // 비밀번호 확인
            if (!password.equals(confirmPassword)) {
                errorMessage = "비밀번호가 일치하지 않습니다.";
            } else {
                Connection conn = null;
                PreparedStatement pstmt = null;
                ResultSet rs = null;
                
                try {
                    // DB 연결 정보 설정
                    String jdbcUrl = "jdbc:mysql://localhost:3306/fs_semi";
                    String dbUser = "root";  // 실제 DB 사용자 이름으로 변경 필요
                    String dbPassword = "1234";  // 실제 DB 비밀번호로 변경 필요
                    
                    // JDBC 드라이버 로드
                    Class.forName("com.mysql.jdbc.Driver");
                    
                    // DB 연결
                    conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);
                    
                    // ID 중복 체크
                    String checkSql = "SELECT id FROM users WHERE id = ?";
                    pstmt = conn.prepareStatement(checkSql);
                    pstmt.setString(1, id);
                    rs = pstmt.executeQuery();
                    
                    if (rs.next()) {
                        errorMessage = "이미 사용 중인 아이디입니다.";
                    } else {
                        // 회원가입 처리
                        String regist_day = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
                        
                        String sql = "INSERT INTO users (id, password, name, gender, birth, email, phone, address, regist_day) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
                        if (pstmt != null) pstmt.close();
                        pstmt = conn.prepareStatement(sql);
                        pstmt.setString(1, id);
                        pstmt.setString(2, password);  // 실제로는 암호화 처리를 해야 함
                        pstmt.setString(3, name);
                        pstmt.setString(4, gender);
                        pstmt.setString(5, birth);
                        pstmt.setString(6, email);
                        pstmt.setString(7, phone);
                        pstmt.setString(8, address);
                        pstmt.setString(9, regist_day);
                        
                        int result = pstmt.executeUpdate();
                        
                        if (result > 0) {
                            successMessage = "회원가입이 완료되었습니다. 로그인 페이지로 이동합니다.";
                            isRegistered = true;
                        } else {
                            errorMessage = "회원가입 처리 중 오류가 발생했습니다.";
                        }
                    }
                    
                } catch (Exception e) {
                    errorMessage = "회원가입 처리 중 오류가 발생했습니다: " + e.getMessage();
                    e.printStackTrace();
                } finally {
                    // 리소스 해제
                    if (rs != null) try { rs.close(); } catch (Exception e) {}
                    if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
                    if (conn != null) try { conn.close(); } catch (Exception e) {}
                }
            }
        }
    %>
    
    <section class="register-section">
        <div class="register-container">
            <div class="register-header">
                <h1>회원가입</h1>
                <p>K-Food Guide의 회원이 되어 다양한 서비스를 이용해보세요.</p>
            </div>
            
            <% if (!errorMessage.isEmpty()) { %>
            <div class="error-message">
                <%= errorMessage %>
            </div>
            <% } %>
            
            <% if (!successMessage.isEmpty()) { %>
            <div class="success-message">
                <%= successMessage %>
                <script>
                    setTimeout(function() {
                        window.location.href = "login.jsp";
                    }, 3000);
                </script>
            </div>
            <% } %>
            
            <% if (!isRegistered) { %>
            <form class="register-form" action="register.jsp" method="post">
                <div class="form-group">
                    <label for="id">아이디 *</label>
                    <input type="text" id="id" name="id" value="<%= id %>" required>
                </div>
                <div class="form-group">
                    <label for="password">비밀번호 *</label>
                    <input type="password" id="password" name="password" required>
                </div>
                <div class="form-group">
                    <label for="confirmPassword">비밀번호 확인 *</label>
                    <input type="password" id="confirmPassword" name="confirmPassword" required>
                </div>
                <div class="form-group">
                    <label for="name">이름 *</label>
                    <input type="name" id="name" name="name" required>
                </div>
                <div class="form-group">
                    <label>성별</label>
                    <div class="gender-options">
                        <div class="gender-option">
                            <input type="radio" id="male" name="gender" value="male" <%= "male".equals(gender) ? "checked" : "" %>>
                            <label for="male">남성</label>
                        </div>
                        <div class="gender-option">
                            <input type="radio" id="female" name="gender" value="female" <%= "female".equals(gender) ? "checked" : "" %>>
                            <label for="female">여성</label>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <label for="birth">생년월일</label>
                    <input type="date" id="birth" name="birth" value="<%= birth %>">
                </div>
                <div class="form-group">
                    <label for="email">이메일 *</label>
                    <input type="email" id="email" name="email" value="<%= email %>" required>
                </div>
                <div class="form-group">
                    <label for="phone">전화번호</label>
                    <input type="tel" id="phone" name="phone" value="<%= phone %>" placeholder="예: 010-1234-5678">
                </div>
                <div class="form-group">
                    <label for="address">주소</label>
                    <textarea id="address" name="address" rows="3"><%= address %></textarea>
                </div>
                <button type="submit">가입하기</button>
            </form>
            <% } %>
        </div>
    </section>
    
    <%@ include file="footer.jsp" %>
</body>
</html>