window.photo_will_be_uploaded = false
$ ->
  $('#new_customer_sign_up').click (e) ->
    e.preventDefault()
    $.post '/customers',
      customer:
        email: $('#customer_email').val()
        password: $('#customer_password').val()
        password_confirmation: $('#password').val()
      claim_cart: $('#claim_cart').length
    $.fancybox.close()
    
  $('#customer_sign_in').click ->
    $.fancybox.close()
  
  $('#uploader_log_in').click ->
    window.photo_will_be_uploaded = true
