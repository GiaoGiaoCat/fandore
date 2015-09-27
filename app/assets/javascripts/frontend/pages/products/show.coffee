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


$(document).on "page:load##{pageId}", (e) ->
  $('.image-preview').slide
    mainCell: '.preview-list ul'
    autoPlay: false
