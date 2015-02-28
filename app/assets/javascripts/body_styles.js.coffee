chosen_filters = ->
  $.map $('.filter:checked'), (filter) ->
    $(filter).attr 'id'

$ ->
  $('#filtered_search').on 'change', '.filter', ->
    $.ajax '/products/filter',
      data: 
        scope_names: chosen_filters()
