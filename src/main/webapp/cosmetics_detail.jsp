<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="mvc.model.CosmeticsDTO" %>
<!DOCTYPE html>
<html>
<head>
    <title>화장품 상세 페이지</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/index_style.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <script src="<%= request.getContextPath() %>/resources/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/cos_detail_style.css">
</head>
<body>
<%@ include file="header.jsp"%>
<%
    String returnURL = request.getRequestURI();
    String query = request.getQueryString();
    if (query != null) {
        returnURL += "?" + query;
    }
    request.setAttribute("returnURL", returnURL);
%>

<div class="container py-5 mt-5">
    <div class="main-section mt-5 mb-4 px-5">
        <c:if test="${not empty cosmetic}">
            <!-- 왼쪽 이미지 -->
            <div class="left-image mb-4 mb-md-0">
                <img src="${pageContext.request.contextPath}/resources/img/${cosmetic.image_file}" alt="화장품 이미지" class="main-image img-fluid text-center">
            </div>

            <!-- 오른쪽 정보 -->
			<div class="right-info" style="position: relative; min-height: 300px;">
			    <h2 class="pb-3"><b>${cosmetic.name}</b></h2>
			    <p><strong>브랜드 :</strong> ${cosmetic.brand}
			    <p><strong>가격 :</strong> ${cosmetic.price}원
			    <p><strong>메인성분 :</strong> ${cosmetic.main_ingredient}
			    <p><strong>효과/효능 :</strong> ${cosmetic.effect}
			    <p><strong>카테고리 :</strong> ${cosmetic.category}
			
			    <!-- 하단 고정 좋아요 + 뒤로가기 -->
			    <div style="position: absolute; bottom: 0; left: 0; right: 0; display: flex; justify-content: space-between; align-items: center; padding-top: 12px;">
			        <!-- 좋아요 표시 -->
			        <c:choose>
			            <c:when test="${not empty sessionScope.id}">
			                <span id="likeBtn" style="cursor: pointer; display: inline-flex; align-items: center; font-size: 24px; gap: 4px;">
			                    <span id="likeIcon">${cosmetic.liked ? "❤️" : "🤍"}</span>
			                    <span id="likeCount" style="font-size: 16px; color: #555;">${cosmetic.likes}</span>
			                </span>
			            </c:when>
			            <c:otherwise>
			                <span style="cursor: pointer; display: inline-flex; align-items: center; font-size: 24px; gap: 4px;" onclick="openLoginModal();">
			                    <span>🤍</span>
			                    <span style="font-size: 16px; color: #555;">${cosmetic.likes}</span>
			                </span>
			            </c:otherwise>
			        </c:choose>
			
			        <!-- 뒤로가기 버튼 -->
			        <button class="btn btn-outline-secondary btn-sm" onclick="history.back()">뒤로가기</button>
			    </div>
			</div>

        </c:if>
    </div>
</div>
<!-- 관련 상품 -->
<section class="about-section" style="padding: 60px 0;">
  <div class="container">
    <h3 class="px-5 pb-3">관련 상품</h3>
    <div id="reviewCarousel" class="carousel slide mb-5 px-5" data-bs-interval="false">
      <div class="carousel-inner">
        <c:forEach var="group" items="${relatedGroups}" varStatus="status">
          <div class="carousel-item ${status.first ? 'active' : ''}">
            <div class="row">
              <c:forEach var="r" items="${group}">
                <div class="col-md-3">
				  <div class="card h-100 shadow-sm border-0" style="height: 300px;">
				    <img src="${pageContext.request.contextPath}/resources/img/${r.image_file}" class="card-img-top img-fluid" alt="${r.name}" style="height: 200px; object-fit: cover;">
				    <div class="card-body p-2 text-center" style="height: 110px; overflow: hidden;">
				      <h6 class="card-title" style="margin-bottom: 2px;">${r.name}</h6>
				      <p class="card-text small text-muted" style="margin: 0;">브랜드: ${r.brand}</p>
				      <div style="font-size: 12px; color: #d33; line-height: 1; margin: 4px 0;">
				        ❤️ <span style="font-size: 12px; color: #333;">${r.likes}</span>
				      </div>
				      <a href="cosmetics?action=detail&id=${r.id}" class="btn btn-sm btn-outline-primary">상세보기</a>
				    </div>
				  </div>
				</div>
              </c:forEach>
            </div>
            <button class="carousel-control-prev" type="button" data-bs-target="#reviewCarousel" data-bs-slide="prev">
                <span class="fa-solid fa-chevron-left fa-2x text-dark"></span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#reviewCarousel" data-bs-slide="next">
                <span class="fa-solid fa-chevron-right fa-2x text-dark"></span>
            </button>
          </div>
        </c:forEach>
      </div>
    </div>
  </div>
</section>
<!-- 로그인 필요 모달 -->
<div class="modal fade" id="loginRequiredModal" tabindex="-1" aria-labelledby="loginRequiredLabel" aria-hidden="true">
  	<div class="modal-dialog">
	    <div class="modal-content">
	      	<div class="modal-header">
		        <h5 class="modal-title" id="loginRequiredLabel">로그인 필요</h5>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="닫기"></button>
	      	</div>
	      	<div class="modal-body">
	        	로그인 후 이용 가능합니다.
	      	</div>
	      	<div class="modal-footer border-0">
		        <a href="login.jsp?redirect=${returnURL}" class="btn btn-primary">로그인</a>
		        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
	      	</div>
    	</div>
  	</div>
</div>


<section class="class-section" style="min-height: 160px;">
    <div class="container"></div>
</section>

<%@ include file="footer.jsp"%>

<!-- 좋아요 AJAX 처리 -->
<script>
document.addEventListener('DOMContentLoaded', function () {
    const likeBtn = document.getElementById('likeBtn');
    const likeIcon = document.getElementById('likeIcon');
    const likeCount = document.getElementById('likeCount');
    const cosmeticId = "${cosmetic.id}";

    if (likeBtn) {
        likeBtn.addEventListener('click', function () {
            fetch("cosmetics", {
                method: "POST",
                headers: {
                    "Content-Type": "application/x-www-form-urlencoded"
                },
                body: "action=likeToggle&id=" + cosmeticId
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    likeIcon.textContent = data.liked ? "❤️" : "🤍";
                    likeCount.textContent = data.likeCount;
                } else {
                    alert(data.message || "처리 실패");
                }
            })
            .catch(error => {
                console.error("AJAX 오류:", error);
                alert("서버와 통신 오류 발생");
            });
        });
    }
});

// 로그인 필요 모달
function openLoginModal() {
    const modal = new bootstrap.Modal(document.getElementById('loginRequiredModal'));
    modal.show();
}
</script>

</body>
</html>
