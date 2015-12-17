<% if @sign_in.errors.blank? %>
    $('#mask').click()
    Turbolinks.visit location.href
<% else %>
    # 错误处理
<% end %>
