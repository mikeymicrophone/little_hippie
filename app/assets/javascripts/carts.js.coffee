# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $('.remove a').click (e) ->
    if($('.item').length > 1)
      $('#item_' + $(e.currentTarget).data('item_id')).remove()
    else
      window.location = '/'