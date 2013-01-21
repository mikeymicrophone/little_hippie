# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $('.new_item').validate {'rules': {'item[product_color_id]': 'required', 'item[size_id]': 'required'}}

  $('.colors_for_product input').change (e) ->
			$('.primary_product_image').css('background-color', $(e.currentTarget).data('color-hex')) if e.currentTarget.checked
