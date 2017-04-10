$ ->
  $('#user_profile_attributes_nickname').on 'keypress, keyup', (e) ->
    inputValue = $(this).val()

    if inputValue.length == 0
      return

    $.ajax
      url: "/api/public/profiles/#{inputValue}",
      dataType: 'json'
      method: 'GET'
      success: (response) =>
        $('#nickname-response').remove()

        $nicknameInput = $('#user_profile_attributes_nickname')
        $submitBtn     = $('input[type="submit"]')

        if response == null
          infoClass   = 'warning'
          infoMessage = 'Nickname is not used'

          $submitBtn.prop('disabled', false)
        else
          infoClass   = 'success'
          infoMessage = 'Nickname already in use'

          $submitBtn.prop('disabled', true)

        $nicknameInput.after("<sup id='nickname-response' class='info-#{infoClass}'> #{infoMessage} ")
