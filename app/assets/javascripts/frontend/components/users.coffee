
$ ->
  $(document).on 'click', '.form-signup .btn-login-code', ->
    $input = $('input[name="user[mobile]"]')
    mobile = $input.val()
    $('p.error').remove()
    if mobile
      handleCodeBtn $(@)
      $.post '/verification_codes', to: mobile
    else
      $('<p class="error">请输入手机号码</p>')
        .appendTo $input.closest('.form-group')

handleCodeBtn = ($btn) ->
  $btn.prop 'disabled', true
    .text("重新发送（120s）")
  seconds = 120
  timmer = setInterval ->
    seconds -= 1
    if seconds is 0
      clearInterval timmer
      $btn.prop('disabled', false).text '获取验证码'
    else
      $btn.text("重新发送（#{ seconds }s）")
  , 1000
