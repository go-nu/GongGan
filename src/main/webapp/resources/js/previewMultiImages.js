// 지정된 ID를 가진 img 태그에 파일 미리보기 보여주는 함수
function previewLocalImageTo(previewId, input) {
  const preview = document.getElementById(previewId);

  if (input.files && input.files[0]) {
    preview.src = URL.createObjectURL(input.files[0]);
  } else {
    preview.src = '/resources/img/no_image.jpg';
  }

  preview.style.display = 'block';
}
