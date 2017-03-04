$ ->
  $tabLink    = $('.tablinks')
  $tabContent = $('.tabcontent')

  $tabLink.click ->
    tabId = $(this).attr('id')

    $tabLink.toggleClass('active')
    $tabContent.toggleClass('active')
