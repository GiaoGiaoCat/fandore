pageId = 'frontend-users-addresses-index'

$ ->
  $(document)
  .on 'hidden.bs.modal', "##{pageId} #modal-edit-address", ->
    $(@).removeData('bs.modal')

  .on 'loaded.bs.modal', "##{pageId} #modal-edit-address", ->
    $('#modal-edit-address .city-group').china_city()
