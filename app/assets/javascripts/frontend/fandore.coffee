Turbolinks.enableTransitionCache()


$(document).on 'ready page:load', (e) ->
  # trigger page:load event for specific page
  $(document).trigger "page:load##{fandore.pageId}", [$("##{fandore.pageId}")]

# init page info
$(document).on 'page:change', (e) ->
  # update gon data
  $.globalEval($('#gon').html()) unless window.gon
  $.extend fandore, window.gon
  window.gon = null

  # trigger page:change event for specific page
  $(document).trigger "page:change##{fandore.pageId}"

# trigger page:before-unload event for specific page
$(document).on 'page:before-unload', (e) ->
  $(document).trigger "page:before-unload##{fandore.pageId}"


# global namespace
@fandore =
  back: (refresh) ->
    if refresh
      $(window).one 'popstate', (e) ->
        return unless e.originalEvent.state?.turbolinks
        Turbolinks.visit location.href
    history.back()

  # force element to reflow, about relow:
  # http://blog.letitialew.com/post/30425074101/repaints-and-reflows-manipulating-the-dom-responsibly
  reflow: (el = document) ->
    $(el)[0].offsetHeight

  humanTime: (scope = $('body')) ->
    scope.find('[data-readable-time]').each ->
      el = $(@)
      date = el.data('readable-time')

      date = moment.tz(date, fandore.me.tz)
      str = date.readableTime() || ''
      el.text(str)


$ ->
  Turbolinks.enableProgressBar()
