$ ->
  $('#user_profile_attributes_nickname').on 'keypress, keyup', (e) ->
    inputValue = $(this).val()

    $.ajax
      url: '/api/public/nickname_validation',
      dataType: 'json'
      method: 'GET'
      data:
        id: inputValue
      success: (response) =>
        $('#nickname-response').remove()

        $nicknameInput = $('#user_profile_attributes_nickname')
        $submitBtn     = $('input[type="submit"]')

        if response.result
          infoClass = 'warning'
          
          $submitBtn.prop('disabled', true)
        else
          infoClass = 'success'

          $submitBtn.prop('disabled', false)

        $nicknameInput.after("<sup id='nickname-response' class='info-#{infoClass}'> #{response.message} ")
