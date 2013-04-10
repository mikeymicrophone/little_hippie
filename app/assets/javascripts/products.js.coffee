# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  if $('form.new_item')[0]
    $('#add_to_cart').click ->
      $('form.new_item').trigger 'submit'
  
    $('form.new_item').validate rules:
      'item[product_color_id]': 'required'
      'item[size_id]': 'required'

  $('.colors_for_product input').change (e) ->
    $('.primary_product_image img').css('background-color', $(e.currentTarget).data('color-hex')) if e.currentTarget.checked
			
  $('.colors_for_product .color_option').mouseover (e) ->
    $('.primary_product_image img').css('background-color', $(e.currentTarget).data('color-hex'))

  $('.jcarousel').jcarousel()
  $('#left_related_products_control').jcarouselControl({target: '-=1'})
  $('#right_related_products_control').jcarouselControl({target: '+=2'})
  
  $('#add_to_cart').click ->
    if($('#product_quantity').val() > 1)
      $('#item_quantity').val $('#product_quantity').val()
  
  $('#add_to_wishlist').click ->
    $.ajax '/wishlist_items',
      data:
        wishlist_item:
          product_color_id: $('.colors_for_product input:checked').val()
          size_id: $('.sizes_for_product input:checked').val()
      type: 'POST'

  $('#email_to_friend').click ->
    $('#email_friend_link').trigger('click')
    $('#friend_email_size_id').val($('.sizes_for_product input:checked').data('size_id'))
    $('#friend_email_color_id').val($('.colors_for_product input:checked').data('color_id'))
    
  $('#email_friend_link').fancybox();
  
  $('#new_friend_email').validate
    rules:
      'friend_email[email]':
        required: true
        email: true
        
  $('#new_friend_email').submit ->
    if($('#new_friend_email').valid())
      $.fancybox.close()
      