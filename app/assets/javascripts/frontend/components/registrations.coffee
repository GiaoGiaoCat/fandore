# 注册弹窗
$ ->
  $(document).on 'click', '.login-form-wrap .login-code', ->
    mobile = $('input[name="user[mobile]"]').val()
    $.post '/verification_codes', to: mobile
