$ ->
statChart = $('#account-chart').get(0).getContext('2d')
data = $('#account-chart').data('chart')

new Chart(statChart,
  type: 'line'
  data: data
)
