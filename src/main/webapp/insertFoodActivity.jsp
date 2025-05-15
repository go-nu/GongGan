<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
    <title>체험 활동 등록</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        .container { max-width: 800px; }
        .preview-img { max-width: 150px; margin-top: 10px; }
    </style>
</head>
<body>
<div class="container mt-5">
    <h2>체험 활동 등록</h2>
    <form action="processInsertFoodActivity.jsp" method="post" enctype="multipart/form-data">
        <div class="mb-3">
            <label class="form-label">제목</label>
            <input type="text" name="TITLE" class="form-control" required>
        </div>
        <div class="mb-3">
            <label class="form-label">가격</label>
            <input type="number" name="PRICE" class="form-control" required>
        </div>
        <div class="mb-3">
            <label class="form-label">이미지 파일</label>
            <input type="file" name="IMG" class="form-control" accept="image/*">
        </div>
        <div class="mb-3">
            <label class="form-label">정원</label>
            <input type="number" name="MAX_COUNT" class="form-control" required>
        </div>
        <div class="mb-3">
            <label class="form-label">체험일자</label>
            <input type="text" name="ACT_DATE" class="form-control" placeholder="예: 2025/05/20 14:00" required>
        </div>
        <div class="mb-3">
            <label class="form-label">주소</label>
            <input type="text" name="ADDRESS" class="form-control" required>
        </div>
        <div class="mb-3">
            <label class="form-label">설명</label>
            <textarea name="NOTE" class="form-control" rows="4"></textarea>
        </div>
        <div class="text-end">
            <button type="submit" class="btn btn-success">등록 완료</button>
            <a href="admin_FoodActivity.jsp" class="btn btn-secondary">취소</a>
        </div>
    </form>
</div>
</body>
</html>
