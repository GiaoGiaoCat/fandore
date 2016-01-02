<% if @address.errors.blank? %>
  $('#modal-new-address').modal('hide')
  fandore.dialog '提示', '地址添加成功！'
  setTimeout ->
    Turbolinks.visit location.href
  , 1500
<% else %>
  errors = $.parseJSON "<%= j @address.errors.to_formatted_json %>"
  fandore.handleErrors(errors)
<% end %>