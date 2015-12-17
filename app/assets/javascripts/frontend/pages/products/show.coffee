pageId = 'frontend-products-show'


$(document).on "page:load##{pageId}", (e) ->
  unless $('.page').hasClass('fullpage-wrapper')
    $('.page').fullpage()

.on "page:before-unload##{pageId}", (e) ->
  $.fn.fullpage.destroy()
  $('html').removeClass('fp-enabled').attr 'style', ''


# renderPrice = ->
#   name = "#{ $('.diamond-weight').text() }-#{ $('[name=product_color]:checked').val() }-#{ $('[name=product_jingdu]:checked').val() }".toLowerCase()
#   diamond = $("[data-name='#{ name }']")
#   price = diamond.text() * 1 + $('input[type=radio]:checked + .product-style').data('price') * 1
#   $('.product-price').text "￥#{ price }"
#   $('#diamond_id').val "#{ diamond.attr 'id' }"
