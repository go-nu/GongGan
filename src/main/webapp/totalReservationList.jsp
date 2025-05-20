<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ include file="dbconn.jsp" %>

<section class="about-section">
    <div class="container">
        <div class="section-title">
            <h2 class="mb-3">전체 프로그램</h2>
            <a class="btn btn-md btn-primary mb-2" href="insertFoodActivity.jsp">추가 등록</a>
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
							<button class="btn btn-sm btn-warning toggle-btn" type="button"
							        data-bs-toggle="collapse"
							        data-bs-target="#<%= collapseId %>"
							        aria-expanded="false"
							        aria-controls="<%= collapseId %>">
							    +
							</button>
					    </td>
					    <td>
							<a href="updateFoodActivity.jsp?ACT_ID=<%= rs.getString("act_id") %>&returnURL=<%= java.net.URLEncoder.encode(request.getRequestURI(), "UTF-8") %>" class="btn btn-sm btn-success">
                                →
                            </a>
						</td>
					    <td>
							<!-- 삭제 버튼 -->
		<%-- 					<a href="deleteFoodActivity.jsp?ACT_ID=<%= rs.getString("ACT_ID") %>&returnURL=<%= java.net.URLEncoder.encode(request.getRequestURI(), "UTF-8") %>" class="btn btn-sm btn-danger"
							   data-bs-toggle="modal"
							   data-bs-target="#deleteModal"
							   data-act-id="<%= rs.getString("ACT_ID") %>"
							>
							    →
							</a> --%>
							<a href="#" class="btn btn-sm btn-danger"
							   data-bs-toggle="modal"
							   data-bs-target="#deleteModal"
							   data-act-id="<%= rs.getString("act_id") %>"
							   data-return-url="<%= java.net.URLEncoder.encode(request.getRequestURI(), "UTF-8") %>">
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
<!-- 삭제 확인용 모달 -->
<div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="deleteModalLabel">삭제 확인</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="닫기"></button>
      </div>
      <div class="modal-body">
        정말 삭제하시겠습니까?
      </div>
      <div class="modal-footer border-0">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
        <form action="deleteFoodActivity.jsp" method="get">
		  <input type="hidden" name="ACT_ID" value="전달값">
		  <input type="hidden" name="returnURL" value="adminPage.jsp">
		  <button type="submit" class="btn btn-danger">삭제</button>
		</form>
      </div>
    </div>
  </div>
</div>
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
  
  document.addEventListener('DOMContentLoaded', function () {
	    const deleteModal = document.getElementById('deleteModal');
	    const confirmDeleteBtn = document.getElementById('confirmDeleteBtn');

	    deleteModal.addEventListener('show.bs.modal', function (event) {
	      const button = event.relatedTarget;
	      const actId = button.getAttribute('data-act-id');
	      const returnUrl = button.getAttribute('data-return-url');
	      
	      const deleteUrl = `deleteFoodActivity.jsp?ACT_ID=${encodeURIComponent(actId)}&returnURL=${encodeURIComponent(returnUrl)}`;
	      confirmDeleteBtn.setAttribute('href', deleteUrl);
	    });
	  });
</script>


    