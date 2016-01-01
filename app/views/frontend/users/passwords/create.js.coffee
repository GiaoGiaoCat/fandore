<% if @password.errors.blank? %>
  $('#modal-password').modal('hide')
  fandore.dialog '提示', '密码修改成功！'
<% else %>
  errors = $.parseJSON "<%= j @password.errors.to_formatted_json %>"
  fandore.handleErrors(errors)
<% end %>
