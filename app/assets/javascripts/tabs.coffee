$ ->
  # $('.tablinks').first().addClass('active')
  # $('.tabcontent').first().addClass('active')

$(document).on 'click', '.tablinks', ->
  $('.tablinks').removeClass('active')
  $('.tabcontent').removeClass('active')

  providerName = $(this).attr('id')

  $(".tablinks##{providerName}").addClass('active')
  $(".tabcontent##{providerName}").addClass('active')
