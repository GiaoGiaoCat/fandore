<% if @user.errors.blank? %>
  Turbolinks.visit location.href
<% else %>
  errors = $.parseJSON "<%= j @user.errors.to_formatted_json %>"
  fandore.handleErrors(errors)
<% end %>
