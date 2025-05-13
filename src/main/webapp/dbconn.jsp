<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<sql:setDataSource var="dataSource"
    driver="com.mysql.cj.jdbc.Driver"
    url="jdbc:mysql://localhost:3306/fs_semi"
    user="root"
    password="1234" />
<%
    Connection conn = null;
    
    try {
        // 데이터베이스 연결
        String url = "jdbc:mysql://localhost:3306/fs_semi?serverTimezone=UTC";
        String user = "root";
        String password = "1234";
        
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, user, password);
        request.setAttribute("conn", conn);

    } catch (SQLException | ClassNotFoundException ex) {
        out.println("데이터베이스 연결 실패:<br>");
        out.println("SQLException: " + ex.getMessage());
    } finally {
        try {
            if (conn != null && !conn.isClosed()) {
                /* conn.close();  // 연결 종료 */
                /* conn.close();를 넣으면 food페이지가 안열림 */
                /* dbconn을 넣은 파일들은 각각에 conn.close();를 추가함 */
            }
        } catch (SQLException ex) {
            out.println("연결 종료 실패: " + ex.getMessage());
        }
    }
%>