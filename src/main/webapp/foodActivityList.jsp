<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.text.SimpleDateFormat, java.util.Date, java.util.Calendar, java.text.ParseException" %>
<%@ include file="dbconn.jsp" %>

<%
	String pageParam = request.getParameter("page");
    int pageSize = 8;
    int pageNum = 1;
    if (pageParam != null) {
        try {
            pageNum = Integer.parseInt(pageParam);
        } catch (NumberFormatException e) {
            pageNum = 1;
        }
    }
    int startRow = (pageNum - 1) * pageSize;

    SimpleDateFormat sdf = new SimpleDateFormat("yy/M/d HH:mm");
    SimpleDateFormat isoFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss");
    Date now = new Date();
    Calendar cal = Calendar.getInstance();
    cal.setTime(now);
    cal.set(Calendar.HOUR_OF_DAY, 0);
    cal.set(Calendar.MINUTE, 0);
    cal.set(Calendar.SECOND, 0);
    cal.set(Calendar.MILLISECOND, 0);
    now = cal.getTime();

    String countSql = "SELECT COUNT(*) FROM activity WHERE STR_TO_DATE(act_date, '%Y/%c/%e %H:%i') > NOW()";
    PreparedStatement countStmt = conn.prepareStatement(countSql);
    ResultSet countRs = countStmt.executeQuery();
    int totalRows = 0;
    if (countRs.next()) totalRows = countRs.getInt(1);
    int totalPages = (int) Math.ceil(totalRows / (double) pageSize);

    String sql = "SELECT * FROM activity WHERE STR_TO_DATE(act_date, '%Y/%c/%e %H:%i') > NOW() ORDER BY STR_TO_DATE(act_date, '%Y/%c/%e %H:%i') LIMIT ?, ?";
    PreparedStatement pstmt = conn.prepareStatement(sql);
    pstmt.setInt(1, startRow);
    pstmt.setInt(2, pageSize);
    ResultSet rs = pstmt.executeQuery();
%>

<!-- 카드 목록 -->
<div class="row row-cols-1 row-cols-md-4 g-3">
<%
    while(rs.next()) {
        try {
            String actDateStr = rs.getString("act_date");
            Date actDate = sdf.parse(actDateStr);

            Calendar actCal = Calendar.getInstance();
            actCal.setTime(actDate);
            actCal.set(Calendar.HOUR_OF_DAY, 0);
            actCal.set(Calendar.MINUTE, 0);
            actCal.set(Calendar.SECOND, 0);
            actCal.set(Calendar.MILLISECOND, 0);
            actDate = actCal.getTime();

            String isoDateStr = isoFormat.format(actDate);
            
            /* 카드 설명 너무 길어지면 중간에 자르는 기능 */
            String note = rs.getString("note");
		    int maxLength = 50; // 최대 글자 수
		    String displayNote = note.length() > maxLength ? note.substring(0, maxLength) + "..." : note;
%>
    <div class="col">
        <div class="card h-100 shadow-sm border-0">
            <img src="./resources/img/<%=rs.getString("img")%>" class="card-img-top2" alt="...">
            <div class="card-body">
                <h5 class="card-title section-title"><%=rs.getString("title")%></h5>
                <div class="align-items-center gap-3 small mb-2 section-title">
                    <span class="badge d-day-badge" data-dday='<%= isoDateStr %>'></span>
                </div>
                <p class="card-text"><%=displayNote%></p>
            </div>
            <div class="card-footer bg-white border-0 text-center">
                <a href="reservation.jsp?act_id=<%=rs.getString("act_id")%>" class="btn btn-success btn-sm">예약하기</a>
            </div>
        </div>
    </div>
<%
        } catch (ParseException e) {
            continue;
        }
    }
%>
</div>

<!-- Ajax용 페이징 -->
<nav aria-label="Page navigation" class="mt-4">
  <ul class="pagination justify-content-center">
    <%-- 이전 버튼 --%>
    <li class="page-item <%= (pageNum <= 1) ? "disabled" : "" %>">
      <a class="page-link ajax-page" href="?page=<%= pageNum - 1 %>" data-page="<%= pageNum - 1 %>">이전</a>
    </li>

    <%-- 숫자 버튼 --%>
    <% for (int i = 1; i <= totalPages; i++) { %>
      <li class="page-item <%= (i == pageNum) ? "active" : "" %>">
        <a class="page-link ajax-page" href="?page=<%= i %>" data-page="<%= i %>"><%= i %></a>
      </li>
    <% } %>

    <%-- 다음 버튼 --%>
    <li class="page-item <%= (pageNum >= totalPages) ? "disabled" : "" %>">
      <a class="page-link ajax-page" href="?page=<%= pageNum + 1 %>" data-page="<%= pageNum + 1 %>">다음</a>
    </li>
  </ul>
</nav>
