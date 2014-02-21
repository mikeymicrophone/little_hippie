# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $('#banner_tag_tag_type').change ->
    $.ajax('/sale_inclusions/list?group=' + $('#banner_tag_tag_type').val(), {type: 'GET'})