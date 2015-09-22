pageId = 'frontend-welcome-index'

$ ->
  $(document).on 'click', "##{ pageId } .next-arrow", ->
    $.fn.fullpage.moveSectionDown()

$(document).on "page:load##{pageId}", (e) ->
  $('#container').fullpage
    navigation: true
