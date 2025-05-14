<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ include file="dbconn.jsp" %>

<section class="about-section">
    <div class="container">
        <div class="section-title">
            <h2>내가 신청한 프로그램</h2>
        </div>

        <div class="table-responsive">
            <table class="table table-bordered table-hover text-center align-middle">
                <thead class="table-light">
                    <tr>
                        <th>예약번호</th>
                        <th>체험명</th>
                        <th>체험날짜</th>
                        <th>주소</th>
                        <th>예약자명</th>
                        <th>인원 수</th>
                        <th>연락처</th>
                        <th>이동</th>
                        <th>취소</th>
                    </tr>
                </thead>
                <tbody class="bg-white">
                    <%
                        PreparedStatement pstmt = null;
                        ResultSet rs = null;

                        String userId = (String) session.getAttribute("id");

                        if (userId == null) {
                            out.println("<tr><td colspan='8'>로그인이 필요합니다.</td></tr>");
                        } else {
                            String sql = "SELECT r.rsv_num, a.title, a.act_date, a.address, r.rsv_name, r.count, r.phone, r.act_id " +
                                         "FROM reservation r JOIN activity a ON r.act_id = a.act_id WHERE r.id = ?";
                            pstmt = conn.prepareStatement(sql);
                            pstmt.setString(1, userId);
                            rs = pstmt.executeQuery();

                            boolean hasData = false;
                            while (rs.next()) {
                                hasData = true;
                    %>
                    <tr>
                        <td><%= rs.getString("rsv_num") %></td>
                        <td><%= rs.getString("title") %></td>
                        <td><%= rs.getString("act_date") %></td>
                        <td><%= rs.getString("address") %></td>
                        <td><%= rs.getString("rsv_name") %></td>
                        <td><%= rs.getInt("count") %>명</td>
                        <td><%= rs.getString("phone") %></td>
                        <td>
                            <a href="reservation.jsp?act_id=<%= rs.getString("act_id") %>" class="btn btn-sm btn-primary">
                                →
                            </a>
                        </td>
                        <td>
							<button class="btn btn-sm btn-danger" data-bs-toggle="modal" data-bs-target="#cancelModal" 
							    data-rsvnum="<%= rs.getString("rsv_num") %>">
							    취소
							</button>
                        </td>
                    </tr>
                    <%
                            }
                            if (!hasData) {
                                out.println("<tr><td colspan='9'>예약 내역이 없습니다.</td></tr>");
                            }

                            if (rs != null) rs.close();
                            if (pstmt != null) pstmt.close();
                        }
                    %>
                </tbody>
            </table>
            <!-- 예약 취소 확인 모달 -->
			<div class="modal fade" id="cancelModal" tabindex="-1" aria-labelledby="cancelModalLabel" aria-hidden="true">
			  	<div class="modal-dialog">
			    	<form method="post" action="reservationCancel.jsp">
				      	<div class="modal-content">
				        	<div class="modal-header">
					          	<h5 class="modal-title" id="cancelModalLabel">예약 취소 확인</h5>
					          	<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="닫기"></button>
				        	</div>
				        	<div class="modal-body">
				          		정말 이 예약을 취소하시겠습니까?
				          		<input type="hidden" name="rsv_num" id="modalRsvNum">
				        	</div>
				        	<div class="modal-footer">
					          	<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">아니오</button>
					          	<button type="submit" class="btn btn-danger">예</button>
				        	</div>
				      	</div>
			    	</form>
			  	</div>
			</div>
        </div>
    </div>
</section>
<script>
  	const cancelModal = document.getElementById('cancelModal');
  	cancelModal.addEventListener('show.bs.modal', function (event) {
	    const button = event.relatedTarget;
	    const rsvNum = button.getAttribute('data-rsvnum');
	    document.getElementById('modalRsvNum').value = rsvNum;
  	});
</script>
    