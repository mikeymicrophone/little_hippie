# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  if $('form.new_item')[0]
    $('#add_to_cart').click ->
      $('form.new_item').trigger 'submit'
  
    $('form.new_item').validate 'rules':
      'item[product_color_id]': 'required'
      'item[size_id]': 'required'
      
  if ($('.colors_for_product input').length == 1)
    $('.colors_for_product input').click()

  if ($('.sizes_for_product input').length == 1)
    $('.sizes_for_product input').click()

  $('.colors_for_product input').change (e) ->
    if e.currentTarget.checked
      $('.primary_product_image #product_image').css('background-color', $(e.currentTarget).data('color-hex'))
      $('.primary_product_image #product_image').attr('src', $(e.currentTarget).data('product-color-image'))
    $('.size_option input').each (i, size) ->
      console.log($(e.currentTarget).data('quantity_' + $(size).data('size_id')))
      if ($(e.currentTarget).data('quantity_' + $(size).data('size_id')) > 0)
        $(size).closest('.size_option').removeClass 'out_of_stock'
      else
        $(size).closest('.size_option').addClass 'out_of_stock'
    $('.colors_for_product input').each (i, color) ->
      if $(color).prop('checked')
        $(color).closest('label').addClass 'color_selected'
      else
        $(color).closest('label').removeClass 'color_selected'
        
  $('.sizes_for_product input').change (e) ->
    $('.colors_for_product input').each (i, color) ->
      if ($(color).data('quantity_' + $(e.currentTarget).data('size_id')) > 0)
        $(color).closest('.color_option').removeClass 'out_of_stock'
      else
        $(color).closest('.color_option').addClass 'out_of_stock'
    $('.sizes_for_product input').each (i, size) ->
      if $(size).prop('checked')
        $(size).closest('label').addClass 'size_selected'
      else
        $(size).closest('label').removeClass 'size_selected'
        
  $('.colors_for_product').on 'mouseenter', '.color_option.out_of_stock', (e) ->
    $('#color_out_of_stock').show().css({'top':e.pageY,'left':e.pageX})

  $('.colors_for_product').on 'mouseleave', '.color_option.out_of_stock', (e) ->
    $('#color_out_of_stock').hide()

  $('.sizes_for_product').on 'mouseenter', '.size_option.out_of_stock', (e) ->
    $('#size_out_of_stock').show().css({'top':e.pageY,'left':e.pageX})

  $('.sizes_for_product').on 'mouseleave', '.size_option.out_of_stock', (e) ->
    $('#size_out_of_stock').hide()
  		
  $('.colors_for_product .color_option').mouseover (e) ->
    $('.primary_product_image #product_image').css('background-color', $(e.currentTarget).data('color-hex'))
    $('.primary_product_image #product_image').attr('src', $(e.currentTarget).data('product-color-image'))

  $('.jcarousel').jcarousel()
  $('.similar_products').each (i, display_group) ->
    console.log($(this).data('number_of_products'))
    $(this).closest('.jcarousel ul').css('width', $(this).data('number-of-products') * 150 + 'px')
  
  $('#product_quantity').blur ->
    $('#item_quantity').val $('#product_quantity').val()
  
  $('#add_to_wishlist').click ->
    if($('.colors_for_product input:checked').val())
      if($('.sizes_for_product input:checked').val())
        $.ajax '/wishlist_items',
          data:
            wishlist_item:
              product_color_id: $('.colors_for_product input:checked').val()
              size_id: $('.sizes_for_product input:checked').val()
          type: 'POST'
      else
        alert('Please choose the size you would like.')
    else
      alert('Please choose the color you would like.')

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
        load_inventory(JSON.parse(inventory_json.responseText))

  $('.product_like').click (event) ->
    console.log($(event.currentTarget).data())
    facebook_like_item $(event.currentTarget).data('product_url')

  $('.design_like').click (event) ->
    facebook_like_item $(event.currentTarget).data('design_url')

  $('.gallery_like').click (event) ->
    facebook_like_item $(event.currentTarget).data('banner_url')
    
  $('.bulletin_like').click (event) ->
    if (FB.getUserID() != "")
      FB.api '/' + $(event.currentTarget).data('photo_id') + '/likes', 'post', {}, (response) ->
        if (!response || response.error)
          console.log 'Error occured', response.error
        else
          console.log 'Post ID: ' + response.id
    else
      FB.login ((response) ->
        FB.api '/' + $(event.currentTarget).data('photo_id') + '/likes', 'post', {}, (response) ->
          if (!response || response.error)
            console.log 'Error occured', response.error
          else
            console.log 'Post ID: ' + response.id
        $.ajax('/facebook_session');
      ),
        scope: 'email, publish_actions, publish_stream, user_birthday'
  
  $('#product_copy_link').click (event) ->
    $('.logistical_tab').hide();
    $('#product_copy').show();
  
  $('#size_chart_link').click (event) ->
    $('.logistical_tab').hide();
    $('#size_chart').show();

  $('#shipping_info').click (event) ->
    $('.logistical_tab').hide();
    $('#shipping_information').show();

  $('#returns_info').click (event) ->
    $('.logistical_tab').hide();
    $('#returns_information').show();

facebook_like_item = (fb_og_url) ->
  if (FB.getUserID() != "")
    FB.api '/' + FB.getUserID() + '/og.likes', 'post', {'object': fb_og_url}, (response) ->
      if (!response || response.error)
        console.log 'Error occured', response.error
      else
        console.log 'Post ID: ' + response.id
  else
    FB.login ((response) ->
      FB.api '/' + FB.getUserID() + '/og.likes', 'post', {'object': fb_og_url}, (response) ->
        if (!response || response.error)
          console.log 'Error occured', response.error
        else
          console.log 'Post ID: ' + response.id
      $.ajax('/facebook_session');
    ),
      scope: 'email, publish_actions, publish_stream, user_birthday'

load_inventory = (inventory) ->
  $('.color_option input').each (i, color) ->
    $('.size_option input').each (j, size) ->
      if inventory[$(color).data('color_id')]
        $(color).attr 'data-quantity_' + $(size).data('size_id'),
          inventory[$(color).data('color_id')][$(size).data('size_id')]