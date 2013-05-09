$ ->
  $('#new_customer_sign_up').click (e) ->
    e.preventDefault()
    # the beta invitation redemption system
    # $.post '/invitations/' + $('#beta_code').val() + '/exchange',
    #   customer:
    #     email: $('#customer_email').val()
    #     password: $('#customer_password').val()
        
    
    # this is the code for when the beta period is over.
    $.post '/customers',
      customer:
        email: $('#customer_email').val()
        password: $('#customer_password').val()
        password_confirmation: $('#password').val()
      claim_cart: $('#claim_cart').length
    $.fancybox.close()
    
  $('#customer_sign_in').click ->
    $.fancybox.close()