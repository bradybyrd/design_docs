$(document).ready ->
  $('#user_password_confirmation').bind 'blur', ->
    if $('#user_password').val() != $('#user_password_confirmation').val()
      $('#confirm_message').html("Passwords do not match");
    else if $('#user_password').val().length < 8
      $('#confirm_message').html("Password must be at least 8 characters");
    else
      $('#confirm_message').html("");
      

