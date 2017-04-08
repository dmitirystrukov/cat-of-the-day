$ ->
  $profileChart = $('#user-profile-chart')

  if $profileChart.length > 0
    profileContext = $profileChart.get(0).getContext('2d')
    profileData    = $profileChart.data('chart')

    new Chart(profileContext,
      type: 'line',
      data: profileData
    )
