function previewLocalImage(input) {
  const preview = document.getElementById('imagePreview');

  if (input.files && input.files[0]) {
    preview.src = URL.createObjectURL(input.files[0]); // 사용자가 업로드한 이미지
  } else {
    preview.src = '<%= request.getContextPath() %>/resources/img/no_image.jpg'; // 예비 이미지
  }

  preview.style.display = 'block';
}
