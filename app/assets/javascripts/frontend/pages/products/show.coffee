pageId = 'frontend-products-show'

$ ->
  $(document)
    .on 'change', "##{ pageId } .render-price", renderPrice
    .on 'click', "##{ pageId } .product-variants label", ->
      $weight = $('#diamond-weight')
      if $(@).is('.product-variants label:last') then $weight.text '0.5CT' else $weight.text '0.3CT'
      $('#product-color').val 'F'
      $('#product-jingdu').val 'VVS2'


$(document).on "page:load##{pageId}", (e) ->
  unless $('.page').hasClass('fullpage-wrapper')
    $('.page').fullpage()

  renderPrice()

.on "page:before-unload##{pageId}", (e) ->
  $.fn.fullpage.destroy()
  $('html').removeClass('fp-enabled').attr 'style', ''


renderPrice = ->
  name = "#{ $('#diamond-weight').text() }-#{ $('#product-color').val() }-#{ $('#product-jingdu').val() }".toLowerCase()
  diamond = $("#product-prices li[data-name='#{ name }']")
  $('#price').text "￥#{ diamond.text() * 1 + $('input[name=variant_id]:checked').data('price') * 1 }"
  $('#diamond_id').val "#{ diamond.attr 'id' }"
