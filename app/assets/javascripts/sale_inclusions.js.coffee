# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $('#sale_inclusion_inclusion_type').change ->
    $.ajax('/sale_inclusions/list?group=' + $('#sale_inclusion_inclusion_type').val() + '&inclusion_id=' + $('#sale_inclusion_inclusion_id').val(), {type: 'GET'})
