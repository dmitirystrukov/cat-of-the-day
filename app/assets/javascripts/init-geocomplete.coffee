$ ->
  $profileLocation = $('#user_profile_attributes_location')

  if $profileLocation.length > 0
    $profileLocation.geocomplete()
