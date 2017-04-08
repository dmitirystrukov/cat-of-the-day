$ ->
  $accountChart = $('#account-chart')

  if $accountChart.length > 0
    accountContext = $accountChart.get(0).getContext('2d')
    accountData    = $accountChart.data('chart')

    new Chart(accountContext,
      type: 'line'
      data: accountData
    )
