# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

reposition_splotches = ->
  $('#customer').css({'background-image': $('#customer').css('background-image'), 'margin-left': 0 - ((1460 - window.innerWidth) / 2)})

$ ->
  reposition_splotches()
  $(window).bind 'resize', ->
    reposition_splotches()
  $('#featured_items_banner1').carousel({interval: 7000});
  $('#featured_items_banner2').carousel({interval: 7500});
  $('#featured_items_banner3').carousel({interval: 8000});
  $('#square_banner1').carousel({interval: 8500});
  $('#square_banner2').carousel({interval: 9000});
  $('#square_banner3').carousel({interval: 9500});
  $('#square_banner4').carousel({interval: 10000});

  $('.pause_button').bind 'click', ->
    if($(this).children('img').first().attr('src').match(/pause/))
      $(this).closest('.carousel').carousel('pause')
      $(this).children('img').first().attr('src', '/assets/play_button.png')
    else
      $(this).closest('.carousel').carousel('cycle')
      $(this).children('img').first().attr('src', '/assets/pause_button.png')
