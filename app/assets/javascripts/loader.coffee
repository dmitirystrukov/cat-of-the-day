$ ->
  $(document).ajaxSend ->
    excludingPaths = ['/users/sign_up']

    if !excludingPaths.includes(location.pathname)
      $('.wrapper-loader').show()

  $(document).ajaxSuccess ->
    $('.wrapper-loader').hide()
