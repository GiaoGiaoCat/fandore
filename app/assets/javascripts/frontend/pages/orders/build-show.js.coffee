pageId = 'frontend-orders-build-show'

$ ->
  $(document)
    .on 'change', "##{ pageId } input[name=type]", ->
      if $(@).parent().is(':first-child')
        $('.form-group-title').css visibility: 'hidden'
      else
        $('.form-group-title').css visibility: 'visible'
