Turbolinks.pagesCached(0)

$(document).on 'ready page:load', (e) ->
  fandore.initSlide()
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

  handleErrors: (errors) ->
    errorsWithoutFiled = []

    for key, msg of errors
      $field = $("form [name='#{ key }']")

      if $field.length is 0
        errorsWithoutFiled.push msg
        continue

      msg.splice(1)
      $("<p class='error'>#{msg}</p>").insertAfter $field

    if errorsWithoutFiled.length > 0
      fandore.dialog '出错了', errorsWithoutFiled.join('<br>')

  dialog: (title, content) ->
    $('#error-dialog').remove()
    $("""<div class="modal fade" id="error-dialog" tabindex="-1" role="dialog">
        <div class="modal-dialog modal-sm">
          <div class="modal-content">
            <div class="modal-header">
              <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
              <h4 class="modal-title" id="myModalLabel">#{ title }</h4>
            </div>
            <div class="modal-body">#{ content }</div>
            <div class="modal-footer">
              <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            </div>
          </div>
        </div>
      </div>""").appendTo $(document.body)
    $('#error-dialog').modal('show')

  initSlide: ->
    $('.link-toggle-nav').bigSlide
      menu: $('#global-nav')
      push: $('.wrapper')
      menuWidth: '50%'

    $('.link-toggle-right-nav').bigSlide
      menu: $('#sidebar')
      side: 'right'
      menuWidth: '460px'


$ ->
  Turbolinks.enableProgressBar()
