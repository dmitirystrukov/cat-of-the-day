<% if @social_post.valid? %>
  flashMessage = '<%= content_tag :div, I18n.t("social_posts.create.success", provider: @social_post.service_name_humanized ), class: "alert alert-notice" %>'

  $('body').animate { scrollTop: 0 }, 'slow'
  $('body').prepend(flashMessage)

  $('section.tabcontent').append('<%= j render "day_subjects/consumer/tabs/item", social_post: @social_post %>')

  Alert.hide()
<% else %>
  errorMessages = JSON.parse('<%= raw @social_post.errors.to_hash.to_json %>')
  modelName = 'social_post'

  $.each errorMessages, (key, value) ->
    $formField = $("#" + "#{modelName}_#{key}").parent()

    $formField.find('.error').remove()
    $formField.append("<span class='error'> #{value} </span>")
<% end %>
