$ ->
  $('.like').click (event) ->
    if (FB.getUserID() != "")
      FB.api '/' + FB.getUserID() + '/og.likes', 'post', {'url': window.location.href, 'object': window.location.href}, (response) ->
        if (!response || response.error)
          console.log 'Error occured', response.error
        else
          console.log 'Post ID: ' + response.id
    else
      FB.login()

  $('.gallery_like').click (event) ->
    if (FB.getUserID() != "")
      FB.api '/' + FB.getUserID() + '/og.likes', 'post', {'url': event.currentTarget.href, 'object': event.currentTarget.href}, (response) ->
        if (!response || response.error)
          console.log 'Error occured', response.error
        else
          console.log 'Post ID: ' + response.id
    else
      FB.login()
