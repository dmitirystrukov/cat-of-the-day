window.Alert =
  show: ->
    $('.alert').show('slow')
  hide: ->
    ALERT_DEFAULT_DELAY = 5000

    setTimeout ( ->
      $('.alert').hide('slow')
    ), ALERT_DEFAULT_DELAY

$ ->
  Alert.hide()
