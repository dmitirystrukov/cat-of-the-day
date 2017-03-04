$ ->
  $tabLink    = $('.tablinks')
  $tabContent = $('.tabcontent')

  $tabLink.first().addClass('active')
  $tabContent.first().addClass('active')

  $tabLink.click ->
    tabId = $(this).attr('id')

    $tabLink.toggleClass('active')
    $tabContent.toggleClass('active')
