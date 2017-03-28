<% if params[:provider_name].present? %>
  <% provider_names = [ params[:provider_name] ] %>
<% else %>
  <% provider_names = model.connected_provider_names %>
<% end %>

providerName = '<%= params[:provider_name] %>'

$("section##{providerName}").remove()
tabContent = '<%= j render "day_subjects/show/client/tabs/content", provider_names: provider_names, social_posts: @social_posts %>'

if providerName == 'facebook'
  $('section').after(tabContent)
else if providerName == 'twitter'
  $('section').before(tabContent)
  $('section#twitter, #twitter').addClass('active')
