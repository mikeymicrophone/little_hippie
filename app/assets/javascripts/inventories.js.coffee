# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

reposition_splotches = ->
  $('#customer').css('margin-left', 0 - ((1460 - window.innerWidth) / 2))

$ ->
  reposition_splotches()
  $(window).bind 'resize', ->
    reposition_splotches()
