pageId = 'frontend-welcome-index'

$(document).on "page:load##{pageId}", (e) ->
  $('.page').fullpage()  unless $('.page').hasClass('fullpage-wrapper')

.on "page:before-unload##{pageId}", (e) ->
  $.fn.fullpage.destroy()
  $('html').removeClass('fp-enabled').attr 'style', ''
