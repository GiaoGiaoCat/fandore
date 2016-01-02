<% if @favorite.errors.blank? %>
  fandore.dialog '提示', '商品收藏成功！'
  setTimeout ->
    Turbolinks.visit location.href
  , 1500
<% else %>
  errors = $.parseJSON "<%= j @favorite.errors.to_formatted_json %>"
  fandore.handleErrors(errors)
<% end %>
