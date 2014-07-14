# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $('#wholesale').on 'click', '.wholesale_group', (event) ->
    $(event.currentTarget).activity()


  $('#wholesale').on 'click', '.wholesale_items_in_cart', (event) ->
    chosen_quantities = {}
    $.map $(event.currentTarget).closest('tr').find('input'), (element, index) ->
      chosen_quantities[($(element).attr('id'))] = $(element).val()
    $.ajax '/wholesale_items',
      type: 'POST'
      data: chosen_quantities
