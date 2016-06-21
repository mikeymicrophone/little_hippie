chosen_filters = ->
  $.map $('.filter:checked'), (filter) ->
    $(filter).attr 'id'

$ ->
  $('#filtered_search').on 'change', '.filter', ->
    $.ajax '/products/filter',
      data: 
        scope_names: chosen_filters()
    unless $(this).prop('checked')
      $('#' + $(this).attr('id') + '_filters').hide('drop')

  $('#filtered_navigation').on 'change', 'label.filter_criterion.color_filter input', ->
    if $(this).prop('checked')
      $(this).closest('label').addClass 'color_selected'
    else
      $(this).closest('label').removeClass 'color_selected'

  $('body').on 'click', '#display_filtered_navigation_toggle', ->
    if $('#filtered_search').css('left') == '0px'
      $('#filtered_search').animate({'left': -230}, 700)
    else
      $('#filtered_search').animate({'left': 0}, 700)
