pageId = 'frontend-welcome-index'

$ ->
  $(document).on 'click', "##{ pageId } .next-arrow", ->
    $.fn.fullpage.moveSectionDown()

$(document).on "page:load##{pageId}", (e) ->
  $('#container').fullpage
    navigation: true
  homeSlide()


homeSlide = ->
  $('.home-slider').slide
    mainCell: '.bd ul'
    autoPlay: true
    interTime: 5000
    delayTime: 1000
    trigger: 'click'
    startFun: (i, c) ->
      children = $('.home-slider .bd li').eq(i).find('.img-box').children()
      delay = 0
      children.opacity 0
      length = children.length
      i = length - 1
      while i >= 0
        children.eq(i).tween
          transform:
            start: 'translateY(-3rem)'
            stop: 'translateY(0rem)'
            time: delay
            duration: .6
            effect: 'cubicInOut'
          opacity:
            start: 0
            stop: 100
            time: delay
            duration: .6
            effect: 'cubicInOut'
        .play()
        delay = delay + 0.1
        i--

  $('.home-pro-left').slide
    mainCell: '.bd ul'
    autoPlay: true
    interTime: 5000
    delayTime: 1000
