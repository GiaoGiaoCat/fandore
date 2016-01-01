<% if @address.errors.blank? %>
  $('#modal-edit-address').modal('hide')
  fandore.dialog '提示', '地址修改成功！'
  setTimeout ->
    Turbolinks.visit location.href
  , 1500
<% else %>
  errors = $.parseJSON "<%= j @address.errors.to_formatted_json %>"
  fandore.handleErrors(errors)
<% end %>
