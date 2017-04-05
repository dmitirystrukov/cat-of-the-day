<% if @social_post.valid? %>
  flashMessage = '<%= content_tag :div, I18n.t("social_posts.create.success", provider: @social_post.service_name_humanized ), class: "alert alert-notice" %>'

  $('body').animate { scrollTop: 0 }, 'slow'
  $('body').prepend(flashMessage)

  serviceName   = '<%= @social_post.service_name_humanized.downcase %>'
  serviceNameId = "##{serviceName}"

  if !!$("a#{serviceNameId}")
    $('ul.tab').append("<li> <a class='tablinks' id='#{serviceName}'> <i class='fa fa-#{serviceName}' /> #{serviceName} </a> </li> ")
    $('section.tabcontent').after("<section class='tabcontent tiles' id='#{serviceName}'/>")

  $("section#{serviceNameId}.tabcontent").append('<%= j render "day_subjects/show/shared/item", social_post: @social_post %>')

  Alert.hide()
<% else %>
  errorMessages = JSON.parse('<%= raw @social_post.errors.to_hash.to_json %>')
  modelName = 'social_post'

  $.each errorMessages, (key, value) ->
    $formField = $("#" + "#{modelName}_#{key}").parent()

    $formField.find('.error').remove()
    $formField.append("<span class='error'> #{value} </span>")
<% end %>
