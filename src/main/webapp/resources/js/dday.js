function calculateDDay(targetDate) {
    const today = new Date();
    const target = new Date(targetDate);
    const diffTime = target - today;
    const days = Math.ceil(diffTime / (1000 * 60 * 60 * 24));  // 일 단위로 계산
    return days;
}

window.addEventListener('DOMContentLoaded', function () {
    const dDayElements = document.querySelectorAll('[data-dday]');

    dDayElements.forEach(function (el) {
        const targetDate = el.getAttribute('data-dday');
        const d = calculateDDay(targetDate);

        // 날짜 차이에 따라 D-Day 텍스트 설정
        el.textContent = d > 0 ? `D-${d}` : d === 0 ? 'D-Day' : '종료';

        // 날짜 차이에 따라 배경 색상 설정
        if (d > 7) {
            el.classList.add('bg-success'); // 7일 이상 남았다면 초록색
        } else if (d <= 7 && d > 3) {
            el.classList.add('bg-warning'); // 3~7일 남았다면 노랑색
        } else if (d <= 3 && d >= 0) {
            el.classList.add('bg-danger'); // 3일 이하 남았다면 빨강색
        } else {
            el.classList.add('bg-dark'); // 이미 지나간 날짜는 검정색
        }
    });
});
