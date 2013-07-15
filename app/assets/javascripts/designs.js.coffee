$ ->
  $('.design_like').click (event) ->
    $(event.currentTarget).attr('src', '/assets/purple_heart.png')
    if (FB.getUserID() != "")
      FB.api '/' + FB.getUserID() + '/og.likes', 'post', {'url': $(event.currentTarget).data('design_url'), 'object': $(event.currentTarget).data('design_url')}, (response) ->
        if (!response || response.error)
          console.log 'Error occured', response.error
        else
          console.log 'Post ID: ' + response.id
    else
      FB.login()
