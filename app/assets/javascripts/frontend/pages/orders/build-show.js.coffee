pageId = 'frontend-orders-build-show'

$ ->
  $(document)
    .on 'change', "##{ pageId } input[name='order[need_invoice]']", ->
      @value = $(@).is(':checked') ? 1 : 0
      $('.form-group-invoice').toggleClass 'active', $(@).is(':checked')

    .on 'change', "##{ pageId } input[name='order[invoice_type]']", ->
      $('.form-group-title').toggleClass 'active', !$(@).parent().is(':first-child')

    .on 'change', "##{ pageId } .section-payment input[name='order[payment_method]']", ->
      $('.payments label.active').removeClass 'active'
      $label = $(@).parent().addClass 'active'
      $('#payment_bank').val $label.find('input').data('bank')
