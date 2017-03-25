$ ->
  $('.tablinks').first().addClass('active')
  $('.tabcontent').first().addClass('active')

$(document).on 'click', '.tablinks', ->
  $('.tablinks').toggleClass('active')
  $('.tabcontent').toggleClass('active')
