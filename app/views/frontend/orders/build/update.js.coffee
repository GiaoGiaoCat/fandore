<% if @order.errors.blank? %>
  alert('do sth!')
  # Turbolinks.visit location.href
<% else %>
  errors = $.parseJSON "<%= j @order.errors.to_formatted_json %>"
  fandore.handleErrors(errors)
<% end %>
