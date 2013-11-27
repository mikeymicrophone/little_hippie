# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $('#age_group').change ->
    $.ajax('/coupon_products/select_category', {data: {category_id: $('#age_group').val()}})
  $('.selectable_body_style').live 'change', (event) ->
    if event.currentTarget.checked
      $.ajax('/coupon_products/select_body_style', {data: {body_style_id: $(event.currentTarget).data('body_style_id')}})
  $('.coupon_product_picker').live 'change', (event) ->
    if event.currentTarget.checked
      $.ajax('/coupon_products', {data: {coupon_product: {product_id: $(event.currentTarget).val(), coupon_id: $('#coupon_id').val()}}, type: 'POST'})
