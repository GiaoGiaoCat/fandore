<% if @order.errors.blank? %>
  alert('do sth!')
  # Turbolinks.visit location.href
<% else %>
  errors = $.parseJSON "<%= j @order.errors.to_formatted_json(as: 'order', accepts_nested_attributes: true) %>"
  fandore.handleErrors(errors)
<% end %>
