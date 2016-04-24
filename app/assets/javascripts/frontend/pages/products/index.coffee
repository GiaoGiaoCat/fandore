pageId = 'frontend-products-index'
$(document).on "page:load##{pageId}", (e) ->
  initMeiqia()


initMeiqia = ->
  if _MEIQIA._INIT
    _MEIQIA._INIT()
  else
    $('#meiqia-script').on 'load', ->
      _MEIQIA._INIT()
