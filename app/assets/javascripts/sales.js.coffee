# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  product_ids = $.map $('.stack'), (p) ->
    $(p).data 'product_id'
  product_color_ids = $.map $('.stack'), (p) ->
    $(p).data 'product_color_id'
  $.ajax '/sale_inclusions/check_products', {data: {product_ids: product_ids}, type: 'GET'}
  $.ajax '/sale_inclusions/check_product_colors', {data: {product_color_ids: product_color_ids}, type: 'GET'}
