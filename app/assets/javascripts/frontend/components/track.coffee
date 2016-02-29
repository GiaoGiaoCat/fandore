# GA数据分析相关代码

$ ->
  return  unless ga

  $(document).on 'click', '#sidebar-signup #btn-signup', ->
    ga('send', 'event', '用户操作', 'click', '注册', 0)

