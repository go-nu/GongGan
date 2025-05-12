<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- <%@ page import="mvc.model.Experience" %> --%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/reservationListstyle.css">
  <script src="<%= request.getContextPath() %>/resources/js/dday.js"></script>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
  <title>reservationList</title>
</head>
<body>

<%@ include file="header.jsp" %>

<!-- 배경 이미지 섹션 -->
<section class="bg-image">	
<div class="overlay">

<!-- 카드 섹션 시작-->
<div class="container pt-5 pb-3">
  <h3 class="mb-4 text-start">Cultural Experiences</h3>
  <div class="row row-cols-1 row-cols-md-2 gy-3 gx-3">
    <!-- 카드 1 -->
    <div class="col">
      <div class="card h-100 shadow-sm border-0">
        <img src="./resources/img/exs01.jpg" class="card-img-top" alt="...">
        <div class="card-body">
          <div class="d-flex align-items-center mb-1">
           <h5 class="card-title">Landscape & Cityscape</h5>
           <span class="badge d-day-badge ms-3" data-dday="2025-06-05"></span>
          </div>
          <div class="d-flex align-items-center gap-3 small text-muted mb-2">
            <div><i class="bi bi-eye"></i> 120</div>
            <div><i class="bi bi-chat-left"></i> 3</div>
            <div><i class="bi bi-heart"></i> 15</div>
          </div>
          <p class="card-text">Describe your forum category. Engage your audience and entice them to continue reading.</p>
        </div>
        <div class="card-footer bg-white border-0 text-end">
          <a href="#" class="btn btn-sm btn-outline-primary">예약하기</a>
        </div>
      </div>
    </div>

    <!-- 카드 2 -->
    <div class="col">
      <div class="card h-100 shadow-sm border-0">
        <img src="./resources/img/exs02.jpg" class="card-img-top" alt="...">
        <div class="card-body">
         <div class="d-flex align-items-center mb-1">
          <h5 class="card-title">Nature & Wildlife</h5>
          <span class="badge d-day-badge ms-3" data-dday="2025-05-15"></span>
         </div>
          <div class="d-flex align-items-center gap-3 small text-muted mb-2">
            <div><i class="bi bi-eye"></i> 98</div>
            <div><i class="bi bi-chat-left"></i> 3</div>
            <div><i class="bi bi-heart"></i> 15</div>
          </div>
          <p class="card-text">Add your category description here. Be sure to write in an informative way that entices further reading.</p>
        </div>
        <div class="card-footer bg-white border-0 text-end">
          <a href="#" class="btn btn-sm btn-outline-primary">예약하기</a>
        </div>
      </div>
    </div>

    <!-- 카드 3 -->
    <div class="col">
      <div class="card h-100 shadow-sm border-0">
        <img src="./resources/img/exs03.jpg" class="card-img-top" alt="...">
        <div class="card-body">
         <div class="d-flex align-items-center mb-1">
          <h5 class="card-title">Black & White</h5>
          <span class="badge d-day-badge ms-3" data-dday="2025-05-09"></span>
         </div>
           <div class="d-flex align-items-center gap-3 small text-muted mb-2">
            <div><i class="bi bi-eye"></i> 56</div>
            <div><i class="bi bi-chat-left"></i> 3</div>
            <div><i class="bi bi-heart"></i> 15</div>
          </div>
          <p class="card-text">Describe your forum category. Engage your audience and entice them to continue reading.</p>
        </div>
        <div class="card-footer bg-white border-0 text-end">
          <a href="#" class="btn btn-sm btn-outline-primary">예약하기</a>
        </div>
      </div>
    </div>

    <!-- 카드 4 -->
    <div class="col">
      <div class="card h-100 shadow-sm border-0">
        <img src="./resources/img/exs04.jpg" class="card-img-top" alt="...">
        <div class="card-body">
         <div class="d-flex align-items-center mb-1">
          <h5 class="card-title">Macro Photography</h5>
          <span class="badge d-day-badge ms-3" data-dday="2025-08-05"></span>
         </div>	
            <div class="d-flex align-items-center gap-3 small text-muted mb-2">
            <div><i class="bi bi-eye"></i> 42</div>
            <div><i class="bi bi-chat-left"></i> 3</div>
            <div><i class="bi bi-heart"></i> 15</div>
          </div>
          <p class="card-text">Add your category description here. Be sure to write in an informative way that entices further reading.</p>
        </div>
        <div class="card-footer bg-white border-0 text-end">
          <a href="#" class="btn btn-sm btn-outline-primary">예약하기</a>
        </div>
      </div>
    </div>
  </div>
</div>


<!-- 3카드 섹션  -->
<div class="container pt-1 pb-5">
  <div class="row row-cols-1 row-cols-md-3 g-3">
    <!-- 카드 1 -->
    <div class="col">
      <div class="card h-100 shadow-sm border-0">
        <img src="./resources/img/exs05.jpg" class="card-img-top2" alt="...">
        <div class="card-body">
         <div class="d-flex align-items-center mb-1">
          <h5 class="card-title">Landscape & Cityscape</h5>
          <span class="badge d-day-badge ms-3" data-dday="2025-08-05"></span>
         </div>
          <div class="d-flex align-items-center gap-3 small text-muted mb-2">
            <div><i class="bi bi-eye"></i> 120</div>
            <div><i class="bi bi-chat-left"></i> 3</div>
            <div><i class="bi bi-heart"></i> 15</div>
          </div>
          <p class="card-text">Describe your forum category. Engage your audience and entice them to continue reading.</p>
        </div>
        <div class="card-footer bg-white border-0 text-end">
          <a href="#" class="btn btn-sm btn-outline-primary">예약하기</a>
        </div>
      </div>
    </div>
    
     <!-- 카드 2 -->
    <div class="col">
      <div class="card h-100 shadow-sm border-0">
        <img src="./resources/img/exs06.jpg" class="card-img-top2" alt="...">
        <div class="card-body">
         <div class="d-flex align-items-center mb-1">
          <h5 class="card-title">Landscape & Cityscape</h5>
          <span class="badge d-day-badge ms-3" data-dday="2025-08-05"></span>
         </div>
          <div class="d-flex align-items-center gap-3 small text-muted mb-2">
            <div><i class="bi bi-eye"></i> 120</div>
            <div><i class="bi bi-chat-left"></i> 3</div>
            <div><i class="bi bi-heart"></i> 15</div>
          </div>
          <p class="card-text">Describe your forum category. Engage your audience and entice them to continue reading.</p>
        </div>
        <div class="card-footer bg-white border-0 text-end">
          <a href="#" class="btn btn-sm btn-outline-primary">예약하기</a>
        </div>
      </div>
    </div>
    
     <!-- 카드 3 -->
    <div class="col">
      <div class="card h-100 shadow-sm border-0">
        <img src="./resources/img/exs07.jpg" class="card-img-top2" alt="...">
        <div class="card-body">
         <div class="d-flex align-items-center mb-1">
          <h5 class="card-title">Landscape & Cityscape</h5>
          <span class="badge d-day-badge ms-3" data-dday="2025-08-05"></span>
         </div>
          <div class="d-flex align-items-center gap-3 small text-muted mb-2">
            <div><i class="bi bi-eye"></i> 120</div>
            <div><i class="bi bi-chat-left"></i> 3</div>
            <div><i class="bi bi-heart"></i> 15</div>
          </div>
          <p class="card-text">Describe your forum category. Engage your audience and entice them to continue reading.</p>
        </div>
        <div class="card-footer bg-white border-0 text-end">
          <a href="#" class="btn btn-sm btn-outline-primary">예약하기</a>
        </div>
      </div>
     </div>
    </div>
   </div>
  </div>
</section>



<%@ include file="footer.jsp" %> 

</body>
</html>
