# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $('.remove a').click (e) ->
    if($('.item').length > 1)
      $('#item_' + $(e.currentTarget).data('item_id')).remove()
    else
      window.location = '/'

  $('#shipping_address_street').blur (e) ->
    if(!$(e.currentTarget).val().match(/\d/))
      $('#street_must_have_number').text "Please enter a number in the street address."
    else
      $('#street_must_have_number').text ''
      
  $('#shipping_method').change (e) ->
    $.ajax('/carts/1/update_shipping_method', {'type': 'PUT', 'data': {'shipping_method': $(this).val()}})

  $('#shipping_address_state_id').change (e) ->
    if($('#shipping_address_state_id option:selected').text() == 'Connecticut')
      # apply tax
      $('#connecticut_tax').show()
      $.ajax('/carts/1/calculate_tax', {'type': 'GET'})
    else
      # remove tax
      if($('#connecticut_tax').is(":visible"))
        # $('#connecticut_tax').hide()
        $.ajax('/carts/1/remove_tax', {'type': 'GET'})
