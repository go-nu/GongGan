<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/reservation_style.css">
<title>reservation</title>
</head>
<body>

<%@ include file="header.jsp" %>

 
<section class="hero">
        <div class="hero-content">
            <h1>한국 전통 음식을 통해 새로운 경험을 느껴보세요</h1>
            <p>한국 전통 방식을 체험하고, 즐겨보세요. GongGan과 함께 전통적인 한식의 세계로 초대합니다.</p>
            <a href="#" class="hero_btn">한식 체험 예약 하기</a>
        </div>
</section>

<!-- 메인 콘텐츠: 왼쪽 이미지 + 오른쪽 설명 -->
<div class="container mt-5 mb-5">
    <div class="row align-items-center">
        <div class="col-md-6 d-flex justify-content-center">
            <img src="<%= request.getContextPath() %>/resources/img/ev02.jpg" class="img-fluid rounded shadow" style="width: 70%;" alt="Product Main">
        </div>
        <div class="col-md-6">
            <h3>전통 한과 만들기 체험</h3>
            <p class="lead">정성 가득한 전통 한과를 직접 만들어보세요. 가족, 친구와 함께하는 특별한 체험으로 한국의 맛과 멋을 느낄 수 있습니다.</p>
            <ul>
                <li>전통 방식의 한과 제조 과정을 직접 체험</li>
                <li>100% 국산 재료로 안전하고 건강하게</li>
                <li>완성된 한과는 예쁜 포장으로 가져가기 가능</li>
            </ul>
        </div>
    </div>
</div>

<!-- 관련 이미지 -->
<div class="container mb-5">
    <h4 class="mb-3"></h4>
    <div class="d-flex flex-wrap film-strip">
        <img src="<%= request.getContextPath() %>/resources/img/rg01.jpg" class="img-thumbnail hover-zoom" alt="related1">
        <img src="<%= request.getContextPath() %>/resources/img/rg02.jpg" class="img-thumbnail hover-zoom" alt="related2">
        <img src="<%= request.getContextPath() %>/resources/img/rg03.png" class="img-thumbnail hover-zoom" alt="related3">
        <img src="<%= request.getContextPath() %>/resources/img/rg04.jpg" class="img-thumbnail hover-zoom" alt="related4">
        <img src="<%= request.getContextPath() %>/resources/img/rg05.jpg" class="img-thumbnail hover-zoom" alt="related5">
        <img src="<%= request.getContextPath() %>/resources/img/rg06.jpg" class="img-thumbnail hover-zoom" alt="related6">
    </div>
</div>


<!-- 체험 세부 정보칸 -->
<div class="container mt-5 mb-5">
    <div class="row">
        <div class="col-md-12">
            <h4 class="mb-3 text-center">Experience Details</h4>
            <table class="table table-bordered">
                <tbody>
                    <tr>
                        <th scope="row" class="bg-light">체험 내용</th>
                        <td>전통 한과 (유과, 강정 등) 만들기</td>
                    </tr>
                    <tr>
                        <th scope="row" class="bg-light">소요 시간</th>
                        <td>약 2시간</td>
                    </tr>
                    <tr>
                        <th scope="row" class="bg-light">체험 장소</th>
                        <td>[정확한 주소] <br> (대중교통 이용 시: [가까운 지하철역/버스 정류장]에서 [도보/버스] [소요 시간]) <br> (주차 가능 여부: [가능/불가능])</td>
                    </tr>
                    <tr>
                        <th scope="row" class="bg-light">참가 비용</th>
                        <td>성인 30,000원 / 아동 20,000원</td>
                    </tr>
                    <tr>
                        <th scope="row" class="bg-light">포함 사항</th>
                        <td>재료비, 포장재, 체험 지도</td>
                    </tr>
                    <tr>
                        <th scope="row" class="bg-light">최대 인원</th>
                        <td>10명</td>
                    </tr>
                    <tr>
                        <th scope="row" class="bg-light">예약 변경 및 취소</th>
                        <td>[예약 변경 및 취소 가능 기한 및 방법], [취소 시 환불 규정]</td>
                    </tr>
                    <tr>
                        <th scope="row" class="bg-light">추가 안내 사항</th>
                        <td>[알레르기 관련 주의 사항]</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- 체험자 후기칸 - 카드로 구성 - 게시판 연동 필요 -->
<div class="container mb-5">
    <h4 class="mb-4 text-center">Review</h4>
    <div class="row">
        <!-- 후기 카드 1 -->
        <div class="col-md-4 mb-4">
            <div class="card h-100 shadow-sm">
                <img src="<%= request.getContextPath() %>/resources/img/exs01.jpg" class="card-img-top review-img" alt="">
                <div class="card-body">
                    <h5 class="card-title">Mike0543</h5>
                    <p class="card-text">Lorem Ipsum is simply dummy text of the printing and typesetting industry. 
                    Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, 
                    when an unknown printer took a galley of type and scrambled it to make a type specimen book..</p>
                </div>
                <div class="card-footer text-muted text-end">
                    2025년 5월 5일
                </div>
            </div>
        </div>

        <!-- 후기 카드 2 -->
        <div class="col-md-4 mb-4">
            <div class="card h-100 shadow-sm">
                <img src="<%= request.getContextPath() %>/resources/img/exs02.jpg" class="card-img-top review-img" alt="">
                <div class="card-body">
                    <h5 class="card-title">selon0117</h5>
                    <p class="card-text">t is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.</p>
                </div>
                <div class="card-footer text-muted text-end">
                    2025년 5월 3일
                </div>
            </div>
        </div>
        
        <!-- 후기 카드 3 -->
        <div class="col-md-4 mb-4">
            <div class="card h-100 shadow-sm">
                <img src="<%= request.getContextPath() %>/resources/img/exs03.jpg" class="card-img-top review-img" alt="">
                <div class="card-body">
                    <h5 class="card-title">jamie123</h5>
                    <p class="card-text">Contrary to popular belief, Lorem Ipsum is not simply random text. 
                    It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock,</p>
                </div>
                <div class="card-footer text-muted text-end">
                    2025년 5월 3일
                </div>
            </div>
        </div>
    </div>
</div>


<!-- 예약하기 섹션 -->
<div class="container mb-5">
    <div class="bg-light p-4 rounded shadow-sm">
        <h4 class="mb-4 text-center">전통 한과 만들기 체험 예약</h4>
        <form action="reservationDetail.jsp" method="post">
            <div class="text-center mt-4">
                <button type="submit" class="btn btn-primary px-4 py-2 me-3">예약하기</button>
                <a href="javascript:history.back()" class="btn btn-success px-4 py-2">뒤로가기</a>
            </div>
        </form>
    </div>
</div>

<%@ include file="footer.jsp" %> 

</body>
</html>
