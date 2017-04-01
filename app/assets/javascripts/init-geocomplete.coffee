$ ->
  $profileLocation = $('#profile_location')

  if $profileLocation.length > 0
    $('#profile_location').geocomplete()
