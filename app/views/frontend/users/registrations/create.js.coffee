<% if @user.errors.blank? %>
  $('#mask').click()
  Turbolinks.visit location.href
<% else %>
  errors = $.parseJSON "<%= j @user.errors.to_formatted_json %>"
  fandore.handleErrors(errors)
<% end %>
