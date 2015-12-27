pageId = 'frontend-orders-build-show'

$ ->
  $(document)
    .on 'change', "##{ pageId } input[name=invoice]", ->
      if $(@).parent().is(':first-child')
        $('.form-group-title').css visibility: 'hidden'
      else
        $('.form-group-title').css visibility: 'visible'
