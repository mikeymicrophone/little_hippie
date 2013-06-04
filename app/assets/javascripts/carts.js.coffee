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