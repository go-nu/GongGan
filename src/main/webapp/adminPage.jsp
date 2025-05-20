<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*"%>
<%@ page import="mvc.model.BoardDTO"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Admin Page</title>
	<script src="./resources/js/bootstrap.bundle.min.js"></script>
	<link rel="stylesheet" href="./resources/css/ap_style.css">
	<link href="./resources/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />
</head>
<body>
	<%@ include file="header.jsp"%>

	<!-- 슬라이드 -->
	<section class="hero">
		<div id="colorCarousel" class="carousel slide" data-bs-ride="carousel">
			<div class="carousel-inner">
				<div class="carousel-item active">
					<img src="./resources/img/slideimg01.jpg" class="d-block w-100" alt="...">
					<div class="fixed-caption">
						<h3>Admin Page</h3>
						
					</div>
				</div>
			</div>
		</div>
	</section>

	<section class="featured-section">
	    <div class="container">
	        <div class="section-title text-center">
	            <h2 class="mb-4">공지글 작성</h2>
	        </div>
	
	        <div class="row justify-content-center">
	            <div class="col-md-4 text-center">
	                <div class="card py-4" onclick="location.href='BoardWriteForm.do?id=admin&category=food'" style="cursor: pointer;">
	                    <img>
	                    <div class="card-info">
	                        <h3>FOOD 게시판 공지 작성</h3>
	                    </div>
	                </div>
	            </div>
	            <div class="col-md-4 text-center">
	                <div class="card py-4" onclick="location.href='BoardWriteForm.do?id=admin&category=beauty'" style="cursor: pointer;">
	                    <img>
	                    <div class="card-info">
	                        <h3>BEAUTY 게시판 공지 작성</h3>
	                    </div>
	                </div>
	            </div>
	            <div class="col-md-4 text-center">
	                <div class="card py-4" onclick="location.href='BoardWriteForm.do?id=admin&category=location'" style="cursor: pointer;">
	                    <img>
	                    <div class="card-info">
	                        <h3>LOCATION 게시판 공지 작성</h3>
	                    </div>
	                </div>
	            </div>
	        </div>
	    </div>
	</section>


<!-- 체험 활동 -->
	<%@ include file="totalReservationList.jsp" %>	
	
<!-- 맵 관리 -->
	<section class="community-section">
		<div class="container">
			        <div class="section-title">
            <h2>지도 관리</h2>
            <button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#addModal">생일 카페 추가</button>
        </div>

        <div class="table-responsive">
            <table class="table table-bordered table-hover text-center align-middle">
                <thead class="table-light">
                    <tr>
                        <th>카테고리</th>
                        <th>가게명</th>
                        <th>지역</th>
                        <th>주소</th>
                        <th>lat</th>
                        <th>lng</th>
                        <th>수정</th>
                        <th>삭제</th>
                    </tr>
                </thead>
				<tbody class="bg-white">
					<%
					    PreparedStatement pstmtM = null;
					    ResultSet rsM = null;
					
					    String sqlM = "SELECT * FROM map_loc";

					    pstmtM = conn.prepareStatement(sqlM);
					    rsM = pstmtM.executeQuery();
					
					    while (rsM.next()) {

					%>
					<tr>
					    <td><%= rsM.getString("category") %></td>
					    <td><%= rsM.getString("name") %></td>
					    <td><%= rsM.getString("region") %></td>
					    <td><%= rsM.getString("address") %></td>
					    <td><%= rsM.getDouble("lat") %></td>
					    <td><%= rsM.getDouble("lng") %></td>
					    <td>
							<button type="button" class="btn btn-sm btn-primary" data-bs-toggle="modal"
						        data-bs-target="#editModal" data-id="<%= rsM.getInt("id") %>">→</button>
						</td>
						<td>
						    <button type="button" class="btn btn-sm btn-danger" data-bs-toggle="modal"
								data-bs-target="#deleteModal" data-id="<%= rsM.getInt("id") %>">→</button>
						</td>

					</tr>
					
					<%
					    }
					
					    if (rsM != null) rsM.close();
					    if (pstmtM != null) pstmtM.close();
					%>
				</tbody>
	        </table>
        </div>
		</div>
	</section>
	<!-- 추가 -->
	<div class="modal fade" id="addModal" tabindex="-1" aria-labelledby="addModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <form action="createMap.jsp" method="post">
	      <div class="modal-content">
	        <div class="modal-header">
	          <h5 class="modal-title" id="addModalLabel">위치 정보 추가</h5>
	          <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
	        </div>
	        <div class="modal-body">
	          <div class="mb-2"><label>카테고리</label><input type="text" name="category" class="form-control" required></div>
	          <div class="mb-2"><label>가게명</label><input type="text" name="name" class="form-control" required></div>
	          <div class="mb-2"><label>지역</label><input type="text" name="region" class="form-control" required></div>
	          <div class="mb-2"><label>주소</label><input type="text" name="address" class="form-control" required></div>
	          <div class="mb-2"><label>Lat</label><input type="text" name="lat" class="form-control" required></div>
	          <div class="mb-2"><label>Lng</label><input type="text" name="lng" class="form-control" required></div>
	        </div>
	        <div class="modal-footer">
	          <button type="submit" class="btn btn-success">추가</button>
	          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
	        </div>
	      </div>
	    </form>
	  </div>
	</div>
	<!-- 수정 -->
	<div class="modal fade" id="editModal" tabindex="-1" aria-labelledby="editModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <form action="updateMap.jsp" method="post">
	      <div class="modal-content">
	        <div class="modal-header">
	          <h5 class="modal-title" id="editModalLabel">위치 정보 수정</h5>
	          <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
	        </div>
	        <div class="modal-body">
	          <input type="hidden" name="id" id="edit-id">
	          <div class="mb-2"><label>카테고리</label><input type="text" name="category" class="form-control"></div>
	          <div class="mb-2"><label>가게명</label><input type="text" name="name" class="form-control"></div>
	          <div class="mb-2"><label>지역</label><input type="text" name="region" class="form-control"></div>
	          <div class="mb-2"><label>주소</label><input type="text" name="address" class="form-control"></div>
	          <div class="mb-2"><label>Lat</label><input type="text" name="lat" class="form-control"></div>
	          <div class="mb-2"><label>Lng</label><input type="text" name="lng" class="form-control"></div>
	        </div>
	        <div class="modal-footer">
	          <button type="submit" class="btn btn-primary">저장</button>
	          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
	        </div>
	      </div>
	    </form>
	  </div>
	</div>
	<!-- 삭제 -->
	<div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <form action="deleteMap.jsp" method="post">
	      <div class="modal-content">
	        <div class="modal-header">
	          <h5 class="modal-title" id="deleteModalLabel">삭제 확인</h5>
	          <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
	        </div>
	        <div class="modal-body">
	          이 항목을 정말 삭제하시겠습니까?
	          <input type="hidden" name="id" id="delete-id">
	        </div>
	        <div class="modal-footer border-0">
	          <button type="submit" class="btn btn-danger">삭제</button>
	          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
	        </div>
	      </div>
	    </form>
	  </div>
	</div>
		
	<%@ include file="footer.jsp"%>
</body>
</html>
<script>
document.addEventListener('DOMContentLoaded', function () {
  var editModal = document.getElementById('editModal');
  var deleteModal = document.getElementById('deleteModal');

  editModal.addEventListener('show.bs.modal', function (event) {
    var button = event.relatedTarget;
    var id = button.getAttribute('data-id');
    document.getElementById('edit-id').value = id;
  });

  deleteModal.addEventListener('show.bs.modal', function (event) {
    var button = event.relatedTarget;
    var id = button.getAttribute('data-id');
    document.getElementById('delete-id').value = id;
  });
});
</script>
