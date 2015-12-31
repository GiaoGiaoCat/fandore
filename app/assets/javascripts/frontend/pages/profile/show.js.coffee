pageId = 'frontend-users-profile-show'

$ ->
  $(document)
  .on 'change', "##{pageId} #user-avatar", ->
    input = @

    if input.files and input.files[0]
      FR = new FileReader()
      FR.onload = (e) ->
        $('.avatar-preview').attr('src', e.target.result)
      FR.readAsDataURL( input.files[0] )

    $('#update-avatar').submit()

