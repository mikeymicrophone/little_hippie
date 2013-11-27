$ ->
  $('#delete_contacts').click ->
    deletable = $('.destroy_contact:checked').map (i, contact) ->
      contact.value
    deletable_string = "?ids=" + $.makeArray(deletable)
    $(this).attr 'href', $(this).attr('href') + deletable_string