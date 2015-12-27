pageId = 'frontend-orders-build-show'

$ ->
  $(document)
    .on 'change', "##{ pageId } input[name='order[invoice_type]']", ->
      if $(@).parent().is(':first-child')
        $('.form-group-title').css visibility: 'hidden'
      else
        $('.form-group-title').css visibility: 'visible'

    .on 'change', "##{ pageId } .section-payment input[name='payment_method']", ->
      $('.payments label.active').removeClass 'active'
      $(@).parent().addClass 'active'

    .on 'ajax:beforeSend', "##{ pageId } .form-order-payment", (e, xhr, settings) ->
      $lable = $('.payments.bank label.active')
      settings.data += "&bank=#{ $lable.find('input').data('bank') }"  if $lable.length
