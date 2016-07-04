$ ->
  $('.banner_in_gallery_checkbox').change (event) ->
    banner_id = $(this).data('banner_id')
    if $(event.currentTarget).is(':checked')
      $.ajax '/banners/' + banner_id, {'type': 'PUT', 'data': {'banner': {'active_in_gallery': true}}}
    else
      $.ajax '/banners/' + banner_id, {'type': 'PUT', 'data': {'banner': {'active_in_gallery': false}}}

  $('#photo_uploader').on 'click', '#upload_and_grant', ->
    $('#customer_upload_button').activity()
    $.fancybox.close()

  $('#photo_uploader').on 'click', '#photo_upload_terms_display', ->
    $('#photo_upload_terms').show()

  $('#delete_banners').click ->
    deletable = $('.destroy_banner:checked').map (i, banner) ->
      banner.value
    deletable_string = "?ids=" + $.makeArray(deletable)
    $(this).attr 'href', $(this).attr('href') + deletable_string

  sortable_element = $('#items-sortable')
  if sortable_element
    sortable(sortable_element, {
      placeholder: "<img src='/favicon.ico' width='50px'>"
    })
      
    sortable_element.bind('sortupdate', (event, ui) ->
      orders = $(event.currentTarget).children().map( -> return $(this).data("id") ).toArray()
      $('#items_ids').val(JSON.stringify(orders))
    )
