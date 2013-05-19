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
      
  if ($('.colors_for_product input').length == 1)
    $('.colors_for_product input').click()

  if ($('.sizes_for_product input').length == 1)
    $('.sizes_for_product input').click()

  $('.colors_for_product input').change (e) ->
    $('.primary_product_image img').css('background-color', $(e.currentTarget).data('color-hex')) if e.currentTarget.checked
    $('.size_option input').each (i, size) ->
      if ($(e.currentTarget).data('quantity_' + $(size).data('size_id')) > 0)
        $(size).closest('.size_option').removeClass 'out_of_stock'
      else
        $(size).closest('.size_option').addClass 'out_of_stock'
        
  $('.sizes_for_product input').change (e) ->
    $('.colors_for_product input').each (i, color) ->
      if ($(color).data('quantity_' + $(e.currentTarget).data('size_id')) > 0)
        $(color).closest('.color_option').removeClass 'out_of_stock'
      else
        $(color).closest('.color_option').addClass 'out_of_stock'
			
  $('.colors_for_product .color_option').mouseover (e) ->
    $('.primary_product_image img').css('background-color', $(e.currentTarget).data('color-hex'))

  $('.jcarousel').jcarousel()
  $('#left_related_products_control').jcarouselControl({target: '-=1'})
  $('#right_related_products_control').jcarouselControl({target: '+=2'})
  $('.jcarousel ul').css('width', $('.similar_products').data('number-of-products') * 106 + 'px')
  
  $('#product_quantity').blur ->
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
  
  if ($('.product_id_marker')[0])
    $.ajax '/products/' + $('.product_id_marker').data('product_id') + '/check_inventory',
      complete: (inventory_json) ->
        load_inventory JSON.parse inventory_json.responseText
  
  $('.like').click (event) ->
    $(event.currentTarget).closest('.primary_product_image.blackborder').addClass('purpleborder').removeClass('blackborder')
    FB.api '/' + FB.getUserID() + '/og.likes', 'post', {'url': window.location.href, 'object': $('#product_facebook_open_graph_id').data('open_graph_id')}, (response) ->
      if (!response || response.error)
        console.log 'Error occured', response.error
      else
        console.log 'Post ID: ' + response.id

load_inventory = (inventory) ->
  $('.color_option input').each (i, color) ->
    $('.size_option input').each (j, size) ->
      $(color).attr 'data-quantity_' + $(size).data('size_id'),
        inventory[$(color).data('color_id')][$(size).data('size_id')]