chosen_filters = ->
  $.map $('.filter:checked'), (filter) ->
    $(filter).attr 'id'

$ ->
  $('#filtered_search').on 'change', '.filter', ->
    $.ajax '/products/filter',
      data: 
        scope_names: chosen_filters()
    console.log($(this).attr('id'))
    console.log($(this).prop('checked'))
    unless $(this).prop('checked')
      $('#' + $(this).attr('id') + '_filters').hide('drop')

  $('#filtered_navigation').on 'change', 'label.filter_criterion.color_filter input', ->
    if $(this).prop('checked')
      $(this).closest('label').addClass 'color_selected'
    else
      $(this).closest('label').removeClass 'color_selected'
