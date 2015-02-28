chosen_filters = undefined
body_style_selected = false

chosen_filters = ->
  checked_boxes = undefined
  checked_boxes = $('.filter:checked').map((i, filter) ->
    $(filter).attr 'id'
  )
  $(checked_boxes).each (i, box_name) ->
    if box_name.match(/body_style/)
      body_style_selected = true
    return
  if body_style_selected
    checked_boxes.filter (box_name) ->
      if box_name.match(/category/)
        return false
      return
  else
    checked_boxes

$ ->
  $('#filtered_search').on 'change', '.filter', ->
    $.ajax '/products/filter',
      data: 
        scope_names: chosen_filters()
