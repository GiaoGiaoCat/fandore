# 顶部按钮，购物车弹窗，导航
$ ->
  $(document).on 'click', '.menu-btn', ->
    $(@).addClass 'cross'
    $('#home-nav').addClass 'open'
    $('#floatmask').fadeIn 'fast'
    $.fn.fullpage.setAllowScrolling(false)  if $('.section').length

    delay = 0.2
    $('.home-nav-ul ul').children().each ->
      delay += 0.1
      $(@).css
        'animation': 'homenav 0.4s linear ' + delay + 's forwards'
        '-moz-animation': 'homenav 0.4s linear ' + delay + 's forwards'
        '-webkit-animation': 'homenav 0.4s linear ' + delay + 's forwards'
        '-o-animation': 'homenav 0.4s linear ' + delay + 's forwards'
      delay = 0.2

  .on 'click', '#close-nav', ->
    $('.menu-btn').removeClass 'cross'
    $('#home-nav').removeClass 'open'
    setTimeout ->
      $('.home-nav-ul ul').children().removeAttr 'style'
    , 200
    $('#floatmask').fadeOut 'fast'
    $.fn.fullpage.setAllowScrolling(false)  if $('.section').length

  .on 'click', '.show-popup', (e) ->
    $link = $(@)
    $popupbox = $('#popupbox')
    $popupbox.addClass $link.data('size')
    $popupbox.find('#popupbox-content').append $("##{ $link.data('tpl') }").html()
    $popupbox.show().tween(
      opacity:
        start: 0
        stop: 100
        time: 0
        duration: 0.7
        effect: 'easeOut'
      top:
        start: 55
        stop: 50
        time: 0
        units: '%'
        duration: 0.7
        effect: 'easeOut').play()
    $('#floatmask').fadeIn 'fast'

  .on 'click', '#popupbox .close-popup', ->
    $popupbox = $('#popupbox')
    $popupbox.tween(
      opacity:
        start: 100
        stop: 0
        time: 0
        duration: 0.7
        effect: 'easeInOut'
      top:
        start: 50
        stop: 55
        time: 0
        units: '%'
        duration: 0.7
        effect: 'easeInOut'
      onStop: (element) ->
        $popupbox.hide()
        $popupbox.find('#popupbox-content').empty()
    ).play()
    $('#floatmask').fadeOut 'fast'
