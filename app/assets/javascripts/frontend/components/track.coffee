# GA数据分析相关代码

$ ->
  return  unless ga

  $(document)
  .on 'click', '#sidebar-signup #btn-signup', ->
    ga('send', 'event', '用户操作', 'click', '注册', 0)

  .on 'click', '#frontend-products-show .btn-shopping', ->
    ga('send', 'event', '订单操作', 'click', '加入购物车', 0)

  .on 'click', '#frontend-products-show .page-toolbar-btn-service', ->
    ga('send', 'event', '用户操作', 'click', '联系客服', 0)

  .on 'click', '#sidebar .btn-payment', ->
    ga('send', 'event', '购物', 'click', '下订单', 0)

  .on 'click', '#frontend-orders-build-show #btn-payment', ->
    # 订单支付信息
    ga 'ecommerce:addTransaction',
      id: $('#order-number').text()
      revenue: $('#order-price').data('price')
      currency: 'CNY'

    # 订单商品信息
    $('.ga-order-item').each ->
      $item = $(@)
      ga 'ecommerce:addItem',
        id: $item.find('#order-number').text()
        name: $item.find('.order-item-name').val()
        price: $item.find('.order-item-price').val()
        quantity: $item.find('.order-item-quantity').val()

    ga('ecommerce:send')
