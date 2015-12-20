<% if @sign_in.errors.blank? %>
  $('#mask').click()
  Turbolinks.visit location.href
<% else %>
  errors = $.parseJSON "<%= j @sign_in.errors.to_formatted_json %>"
  console.log errors
  fandore.handleErrors(errors)
<% end %>
