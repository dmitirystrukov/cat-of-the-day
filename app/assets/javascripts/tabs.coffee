# TODO Improved it to implement dynamic behavior
window.Tabs =
  init: ->
    $tabLink    = $('.tablinks')
    $tabContent = $('.tabcontent')

    $tabLink.click ->
      tabId = $(this).attr('id')

      $tabLink.toggleClass('active')
      $tabContent.toggleClass('active')

$ ->
  $tabLink    = $('.tablinks')
  $tabContent = $('.tabcontent')

  $tabLink.first().addClass('active')
  $tabContent.first().addClass('active')

  Tabs.init()
