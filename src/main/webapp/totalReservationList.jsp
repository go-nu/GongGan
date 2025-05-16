<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ include file="dbconn.jsp" %>

<section class="about-section">
    <div class="container">
        <div class="section-title">
            <h2>전체 프로그램</h2>
            <p>추가하기</p>
        </div>

        <div class="table-responsive">
            <table class="table table-bordered table-hover text-center align-middle">
                <thead class="table-light">
                    <tr>
                        <th>예약번호</th>
                        <th>체험명</th>
                        <th>체험날짜</th>
                        <th>주소</th>
                        <th>예약 인원</th>
                        <th>정원</th>
                        <th>현황보기</th>
                        <th>수정</th>
                        <th>삭제</th>
                    </tr>
                </thead>
				<tbody class="bg-white">
					<%
					    PreparedStatement pstmt = null;
					    ResultSet rs = null;
					
					    String sql = "SELECT a.act_id, a.title, a.act_date, a.address, " +
					             "(SELECT SUM(count) FROM reservation r WHERE r.act_id = a.act_id) AS total_count, " +
					             "a.max_count " +
					             "FROM activity a";

					    pstmt = conn.prepareStatement(sql);
					    rs = pstmt.executeQuery();
					
					    while (rs.next()) {
					        String actId = rs.getString("act_id");
					        String collapseId = "collapse_" + actId;
					%>
					<tr>
					    <td><%= actId %></td>
					    <td><%= rs.getString("title") %></td>
					    <td><%= rs.getString("act_date") %></td>
					    <td><%= rs.getString("address") %></td>
					    <td><%= rs.getString("total_count") != null ? rs.getInt("total_count") + "명" : "-" %></td>
					    <td><%= rs.getInt("max_count") %>명</td>
					    <td>
							<button class="btn btn-sm btn-success toggle-btn" type="button"
							        data-bs-toggle="collapse"
							        data-bs-target="#<%= collapseId %>"
							        aria-expanded="false"
							        aria-controls="<%= collapseId %>">
							    +
							</button>
					    </td>
					    <td>
							<a href="#" class="btn btn-sm btn-primary">
                                →
                            </a>
						</td>
					    <td>
					    	<a href="#" class="btn btn-sm btn-danger">
                                →
                            </a>
					    </td>
					</tr>
					
					<tr class="collapse bg-light" id="<%= collapseId %>">
					    <td colspan="9">
					        <table class="table table-bordered text-center mb-0">
					            <thead class="table-light">
					                <tr>
					                    <th>예약자명</th>
					                    <th>연락처</th>
					                    <th>예약 인원</th>
					                    <th>예약 ID</th>
					                </tr>
					            </thead>
					            <tbody>
					                <%
					                    PreparedStatement pstmtR = null;
					                    ResultSet rsR = null;
					                    String sqlR = "SELECT rsv_name, phone, count, id FROM reservation WHERE act_id = ?";
					                    pstmtR = conn.prepareStatement(sqlR);
					                    pstmtR.setString(1, actId);
					                    rsR = pstmtR.executeQuery();
					
					                    boolean hasData = false;
					                    while (rsR.next()) {
					                        hasData = true;
					                %>
					                <tr>
					                    <td><%= rsR.getString("rsv_name") %></td>
					                    <td><%= rsR.getString("phone") %></td>
					                    <td><%= rsR.getInt("count") %></td>
					                    <td><%= rsR.getString("id") %></td>
					                </tr>
					                <%
					                    }
					                    if (!hasData) {
					                %>
					                <tr><td colspan="4">예약 내역이 없습니다.</td></tr>
					                <%
					                    }
					                    if (rsR != null) rsR.close();
					                    if (pstmtR != null) pstmtR.close();
					                %>
					            </tbody>
					        </table>
					    </td>
					</tr>
					<%
					    }
					
					    if (rs != null) rs.close();
					    if (pstmt != null) pstmt.close();
					%>
				</tbody>
	        </table>
        </div>
    </div>
</section>
<script>
  document.addEventListener('DOMContentLoaded', function () {
    const toggleButtons = document.querySelectorAll('.toggle-btn');

    toggleButtons.forEach(function (button) {
      const targetSelector = button.getAttribute('data-bs-target');
      const targetEl = document.querySelector(targetSelector);

      if (!targetEl) return;

      // Collapse 인스턴스를 만들지만 자동 toggle 막기
      const collapseInstance = bootstrap.Collapse.getOrCreateInstance(targetEl, { toggle: false });

      // 버튼 초기 상태 설정
      if (targetEl.classList.contains('show')) {
        button.textContent = '−';
      } else {
        button.textContent = '+';
      }

      // 이벤트 리스너 등록
      targetEl.addEventListener('show.bs.collapse', function () {
        button.textContent = '−';
      });

      targetEl.addEventListener('hide.bs.collapse', function () {
        button.textContent = '+';
      });
    });
  });
</script>


    