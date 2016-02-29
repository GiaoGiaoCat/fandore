pageId = 'frontend-products-show'

$ ->
  $(document)
    .on 'change', "##{ pageId } .render-price", renderPrice
    .on 'click', "##{ pageId } .form-engaement-ring .product-variants label", ->
      $weight = $('#diamond-weight')
      if $(@).is('.product-variants label:last') then $weight.text '0.5CT' else $weight.text '0.3CT'
      $('#product-color').val 'F'
      $('#product-jingdu').val 'VVS2'

    .on 'change', "##{ pageId } .form-wedding-rings input[name=variant_name]", ->
      $('.form-control').prop 'disabled', false
      if @value is 'M'
        $('#female_size, #female_lettering').prop 'disabled', true
      else if @value is 'F'
        $('#male_size, #male_lettering').prop 'disabled', true

    .on 'click', "##{ pageId } .page-toolbar-btn-service", ->
      _MEIQIA._SHOWPANEL()



$(document).on "page:load##{pageId}", (e) ->
  unless $('.page').hasClass('fullpage-wrapper')
    $('.page').fullpage()

  renderPrice()
  initMeiqia()

.on "page:before-unload##{pageId}", (e) ->
  $.fn.fullpage.destroy()
  $('html').removeClass('fp-enabled').attr 'style', ''


renderPrice = ->
  if $('.form-inline').hasClass 'form-wedding-rings'
    name = "#{ $('input[name=material]:checked').val() }-#{ $('input[name=variant_name]:checked').val() }"
    $product = $("#product-prices li[data-name='#{ name }']")
    $('#price').text "￥#{ $product.text() * 1 }"
    $('#variant_id').val "#{ $product.attr 'id' }"
  else
    name = "#{ $('#diamond-weight').text() }-#{ $('#product-color').val() }-#{ $('#product-jingdu').val() }".toLowerCase()
    $diamond = $("#product-prices li[data-name='#{ name }']")
    $('#price').text "￥#{ $diamond.text() * 1 + $('input[name=variant_id]:checked').data('price') * 1 }"
    $('#diamond_id').val "#{ $diamond.attr 'id' }"


initMeiqia = ->
  if _MEIQIA._INIT
    _MEIQIA._INIT()
  else
    $('#meiqia-script').on 'load', ->
      _MEIQIA._INIT()
