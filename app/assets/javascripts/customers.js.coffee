$(->
  $('#new_customer_sign_up').click((e)->
    e.preventDefault()
    $.post('/customers', {'customer': {'email': $('#email').val(), 'password': $('#password').val(), 'password_confirmation': $('#password').val()}})
  )
)