# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $('.fancybox').fancybox()

  if (window.location.href.match(/sign_mailing_list/))
    $('#sign_mailing_list').trigger 'click'
    $.scrollTo 0
