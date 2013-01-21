$(->
  $('#new_customer_sign_up').click((e)->
    e.preventDefault()
    $.post('/customers', {'customer': {'email': $('#customer_email').val(), 'password': $('#customer_password').val(), 'password_confirmation': $('#password').val()}, 'claim_cart': $('#claim_cart').length})
    $.fancybox.close()
  )
)