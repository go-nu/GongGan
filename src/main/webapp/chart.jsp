<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<canvas id="genderChart" width="800" height="400"></canvas>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<script>
document.addEventListener("DOMContentLoaded", function () {
  const ctx = document.getElementById('genderChart').getContext('2d');
  new Chart(ctx, {
    data: {
    	labels: [
    		'24.04.', '24.05.', '24.06.', '24.07.', '24.08.', '24.09.',
         	'24.10.', '24.11.', '24.12.', '25.01.', '25.02.', '25.03.'
       	],
      datasets: [
        {
          type: 'bar',
          label: '전체 인원',
          data: [
            1357758, 1312254, 1314228, 1310926,
            1460422, 1361091, 1491733, 1268038,
            1186017, 1032869, 1058227, 1510572
          ],
          backgroundColor: 'rgba(75, 192, 192, 0.4)',
          borderColor: 'rgba(75, 192, 192, 1)',
          borderWidth: 1
        },
        {
          type: 'line',
          label: '남성 인원',
          data: [
            536387, 512578, 502451, 502854, 582254, 532908,
            566945, 485984, 477015, 418324, 446724, 566401
          ],
          borderColor: '#007bff',
          borderWidth: 2,
          fill: false,
          tension: 0.3
        },
        {
          type: 'line',
          label: '여성 인원',
          data: [
            821371, 799676, 811777, 808072, 878168, 828183,
            924788, 782054, 709002, 614545, 611503, 944171
          ],
          borderColor: '#e83e8c',
          borderWidth: 2,
          fill: false,
          tension: 0.3
        }
      ]
    },
    options: {
      responsive: true,
      plugins: {
        legend: { position: 'top' },
        tooltip: { mode: 'index', intersect: false }
      },
      scales: {
        y: {
          beginAtZero: false,
          ticks: {
            callback: function(value) {
              return value.toLocaleString();
            }
          }
        }
      }
    }
  });
});
</script>
