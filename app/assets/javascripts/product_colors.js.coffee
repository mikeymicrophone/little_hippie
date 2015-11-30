$ ->
  $('.product_color_availability_toggle').change (event) ->
    product_color_id = $(event.currentTarget).data('product_color_id')
    if ($(event.currentTarget).prop('checked'))
      $.ajax('/product_colors/' + product_color_id, {data: {'available': true}, type: 'PUT'})
    else
      $.ajax('/product_colors/' + product_color_id, {data: {'available': false}, type: 'PUT'})
