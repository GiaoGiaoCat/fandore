<% if @sign_in.errors.blank? %>
  $('#mask').click()
  Turbolinks.visit '/'
<% else %>
  errors = $.parseJSON "<%= j @sign_in.errors.to_formatted_json %>"
  fandore.handleErrors(errors)
<% end %>
