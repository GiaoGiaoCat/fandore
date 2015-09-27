pageId = 'frontend-welcome-index'

$ ->
  $(document)
  .on 'mouseenter', "##{ pageId } .two-code", ->
    $(@).children('.two-code-img').tween
      opacity:
        start: 0
        stop: 100
        duration: .1
    .play()

  .on 'mouseleave', "##{ pageId } .two-code", ->
    $(@).children('.two-code-img').tween
      opacity:
        start: 100
        stop: 0
        duration: .3
    .play()

$(document).on "page:load##{pageId}", (e) ->
  fullPage()
  homeSlide()
  $(window).load ->
    $('#loading').fadeOut 'fast', ->
      $(@).remove()


fullPage = ->
  header = document.querySelector('header')
  footer = document.querySelector('footer')
  next_arrow = footer.querySelector('.next-arrow')
  slide_obj = document.querySelectorAll('.slide')
  slide_obj_length = slide_obj.length

  next_arrow.onclick = ->
    $.fn.fullpage.moveSectionDown()

  container = $('#container')
  page3_txt = container.children().eq(2)
  page4_txt = page3_txt.next()
  page5_txt = page4_txt.next()
  nav_child = $('.home-nav-child ul')
  login_txt = $('.link-wrap a')
  $('.container').fullpage
    navigation: true
    onLeave: (index, nextIndex, direction) ->
      if nextIndex == 1 or nextIndex == 5
        header.classList.remove 'active'
        footer.classList.remove 'active'
        login_txt.removeClass 'white'
      else
        header.classList.add 'active'
        footer.classList.add 'active'
        login_txt.addClass 'white'

      if nextIndex == 5
        next_arrow.classList.add 'hide'
      else
        next_arrow.classList.remove 'hide'

      switch index
        when 2
          children_animate_out nav_child, .4
        when 3
          page3_txt.find('.page-bg').removeClass 'bg-autoanimate'
        when 4
          page4_txt.find('.page-bg').removeClass 'bg-autoanimate'
      switch nextIndex
        when 2
          children_animate nav_child, .4
        when 3
          page3_txt.find('.page-bg').addClass 'bg-autoanimate'
          children_animate page3_txt.find('.page-box').children(), .4
        when 4
          page4_txt.find('.page-bg').addClass 'bg-autoanimate'
          children_animate page4_txt.find('.page-box').children(), .4
        when 5
          children_animate page5_txt.find('.page-box').children(), .4

    navigation: true
    anchors: ['page1', 'page2', 'page3', 'page4', 'page5']
    menu: '#home-nav'



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


children_animate = (obj, delay) ->
  obj.children().opacity 0
  children = obj.children()
  i = children.length - 1
  while i >= 0
    children.eq(i).tween(
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
        effect: 'cubicInOut').play()
    delay = delay + 0.1
    i--


children_animate_out = (obj, delay) ->
  children = obj.children()
  i = children.length - 1
  while i >= 0
    children.eq(i).tween(
      transform:
        start: 'translateY(0rem)'
        stop: 'translateY(3rem)'
        time: delay
        duration: .6
        effect: 'cubicInOut'
      opacity:
        start: 100
        stop: 0
        time: delay
        duration: .6
        effect: 'cubicInOut').play()
    delay = delay + 0.1
    i--
