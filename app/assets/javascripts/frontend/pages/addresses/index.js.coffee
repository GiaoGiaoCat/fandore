pageId = 'frontend-users-addresses-index'

$ ->
  $(document)
  .on 'hidden.bs.modal', "##{pageId} #modal-edit-address", ->
    $(@).removeData('bs.modal')
