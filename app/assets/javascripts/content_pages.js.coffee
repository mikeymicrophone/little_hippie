$('.content_administration').on 'click', '.full_display_link', (event) ->
  event.preventDefault
  $(this).find('#full_display_of_content_page').css('display', 'block')
  