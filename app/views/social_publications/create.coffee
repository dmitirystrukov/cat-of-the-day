<% if @social_post.valid? %>
  flashMessage = '<%= content_tag :div, I18n.t("social_posts.create.success", provider: @social_post.service_name_humanized ), class: "alert alert-notice" %>'

  $('body').animate { scrollTop: 0 }, 'slow'
  $('body').prepend(flashMessage)

  serviceName   = '<%= @social_post.service_name_humanized.downcase %>'
  serviceNameId = "##{serviceName}"

  if !$("a#{serviceNameId}").length
    tabContent = "<li> <a class='tablinks' id='#{serviceName}'> <i class='fa fa-#{serviceName}' /> #{serviceName} </a> </li>"

    if serviceName == 'facebook'
      $('ul.tab').prepend(tabContent)
    else
      $('ul.tab').append(tabContent)

  if !$("section#{serviceNameId}").length
    sectionContent = "<section class='tabcontent tiles' id='#{serviceName}'/>"

    if serviceName == 'facebook'
      $("section").before(sectionContent)
    else
      $("section").after(sectionContent)


  $("section#{serviceNameId}").append('<%= j render "day_subjects/show/shared/item", social_post: @social_post %>')

  $('.tablinks').removeClass('active')
  $('.tabcontent').removeClass('active')
  
  $(".tablinks##{serviceName}").addClass('active')
  $(".tabcontent##{serviceName}").addClass('active')

  Alert.hide()

<% else %>
  errorMessages = JSON.parse('<%= raw @social_post.errors.to_hash.to_json %>')
  modelName = 'social_post'

  $.each errorMessages, (key, value) ->
    $formField = $("#" + "#{modelName}_#{key}").parent()

    $formField.find('.error').remove()
    $formField.append("<span class='error'> #{value} </span>")
<% end %>
