pageId = 'frontend-products-show'

$ ->
  $(document).on 'click', "##{ pageId } .thumb-image", ->
    $link = $(@)
    return  if $link.hasClass 'active'

    $('.product-image').attr 'src', $link.find('img').attr('src')
    $link.addClass('active').siblings().removeClass 'active'

  .on 'click', "##{ pageId } .link-close-preview", ->
    $('.image-preview').fadeOut()

  .on 'click', "##{ pageId } .link-show-image", ->
    $('.image-preview').fadeIn()

  .on 'click', "##{ pageId } .product-radio", renderPrice
  .on 'click', "##{ pageId } .product-style", ->
    $weight = $('.diamond-weight')
    if $(@).is('.product-styles :last') then $weight.text '0.5CT' else $weight.text '0.3CT'
    $('[for=product-color-3], [for=product-jingdu-3]').click()


$(document).on "page:load##{pageId}", (e) ->
  renderPrice()
  $('.image-preview').slide
    mainCell: '.preview-list ul'
    autoPlay: false


renderPrice = ->
  name = "#{ $('.diamond-weight').text() }-#{ $('[name=product_color]:checked').val() }-#{ $('[name=product_jingdu]:checked').val() }".toLowerCase()
  diamond = $("[data-name='#{ name }']")
  $('.product-price').text "￥#{ diamond.text() }"
  $('[diamond_id]').val "#{ diamond.attr 'id' }"
