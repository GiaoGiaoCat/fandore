
$ ->
  $(document).on 'click', 'a[data-big-slide]', ->
    $link = $(@)
    $mask = $('#mask')
    type = $link.data 'big-slide'

    if type is 'signup'
      $('#sidebar-signup').show().siblings().hide()
    else if type is 'signin'
      $('#sidebar-signin').show().siblings().hide()
    else if type is 'cart'
      $('#sidebar-cart').show().siblings().hide()
    else if type is 'profile'
      $('#sidebar-profile').show().siblings().hide()

    unless $mask.is(':visible')
      $('#mask').data('big-slide', $link).fadeIn 'fast'

  .on 'click', '.link-close-nav, .link-close-sidebar', ->
    $('#mask').click()

  .on 'click', '#mask', ->
    $(@).fadeOut('fast').data('big-slide').click()

  .on 'click', '#sidebar .link-signup', ->
    $('.link[data-big-slide="signin"]').click()
    setTimeout ->
      $('.link[data-big-slide="signup"]').click()
    , 300
    return false

  .on 'click', '#sidebar .link-signin', ->
    $('.link[data-big-slide="signup"]').click()
    setTimeout ->
      $('.link[data-big-slide="signin"]').click()
    , 300
    return false

  .on 'click', '.link-shopping-cart', ->
    $.get @href, (result) ->
      $('#sidebar-cart').removeClass('loading').html(result)
      $('.total-quantity span').text renderCartQuantity()
      $('.total-price span').text renderCartPrice()
    return false

renderCartQuantity = ->
  quantity = 0
  $('.cart-table .quantity').each ->
    quantity += @textContent * 1
  quantity

renderCartPrice = ->
  price = 0
  $('.cart-table .price').each ->
    price += @textContent * 1
  price
