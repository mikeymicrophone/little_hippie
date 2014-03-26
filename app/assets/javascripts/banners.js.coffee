$ ->
  $('.banner_in_gallery_checkbox').change (event) ->
    banner_id = $(this).data('banner_id')
    if $(event.currentTarget).is(':checked')
      $.ajax '/banners/' + banner_id, {'type': 'PUT', 'data': {'banner': {'active_in_gallery': true}}}
    else
      $.ajax '/banners/' + banner_id, {'type': 'PUT', 'data': {'banner': {'active_in_gallery': false}}}

  $('#photo_uploader').on 'click', '#upload_and_grant', ->
    $.fancybox.close()

  $('#photo_uploader').on 'click', '#photo_upload_terms_display', ->
    $('#photo_upload_terms').show()
