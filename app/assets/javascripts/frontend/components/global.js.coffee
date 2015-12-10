
$ ->
  $(document).on 'click', '.link-toggle-nav', ->
    if $(@).hasClass 'active'
      $('#mask').fadeIn 'fast'
    else
      $('#mask').fadeOut 'fast'

  .on 'click', '.link-close-nav', ->
    $('.link-toggle-nav').click()
