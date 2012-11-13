#
# Buttons helper for fancyBox
# version: 1.0.2
# @requires fancyBox v2.0 or later
#
# Usage: 
#     $(".fancybox").fancybox({
#         buttons: {
#             position : 'top'
#         }
#     });
# 
# Options:
#     tpl - HTML template
#     position - 'top' or 'bottom'
# 
#
(($) ->
  F = $.fancybox
  F.helpers.buttons =
    tpl: "<div id=\"fancybox-buttons\"><ul><li><a class=\"btnPrev\" title=\"Previous\" href=\"javascript:;\"></a></li><li><a class=\"btnPlay\" title=\"Start slideshow\" href=\"javascript:;\"></a></li><li><a class=\"btnNext\" title=\"Next\" href=\"javascript:;\"></a></li><li><a class=\"btnToggle\" title=\"Toggle size\" href=\"javascript:;\"></a></li><li><a class=\"btnClose\" title=\"Close\" href=\"javascript:jQuery.fancybox.close();\"></a></li></ul></div>"
    list: null
    buttons: {}
    update: ->
      toggle = @buttons.toggle.removeClass("btnDisabled btnToggleOn")
      if F.current.canShrink
        toggle.addClass "btnToggleOn"
      else toggle.addClass "btnDisabled"  unless F.current.canExpand

    beforeLoad: (opts) ->
      if F.group.length < 2
        F.coming.helpers.buttons = false
        F.coming.closeBtn = true
        return
      F.coming.margin[(if opts.position is "bottom" then 2 else 0)] += 30

    onPlayStart: ->
      @buttons.play.attr("title", "Pause slideshow").addClass "btnPlayOn"  if @list

    onPlayEnd: ->
      @buttons.play.attr("title", "Start slideshow").removeClass "btnPlayOn"  if @list

    afterShow: (opts) ->
      buttons = undefined
      unless @list
        @list = $(opts.tpl or @tpl).addClass(opts.position or "top").appendTo("body")
        @buttons =
          prev: @list.find(".btnPrev").click(F.prev)
          next: @list.find(".btnNext").click(F.next)
          play: @list.find(".btnPlay").click(F.play)
          toggle: @list.find(".btnToggle").click(F.toggle)
      buttons = @buttons
      if F.current.index > 0 or F.current.loop
        buttons.prev.removeClass "btnDisabled"
      else
        buttons.prev.addClass "btnDisabled"
      if F.current.loop or F.current.index < F.group.length - 1
        buttons.next.removeClass "btnDisabled"
        buttons.play.removeClass "btnDisabled"
      else
        buttons.next.addClass "btnDisabled"
        buttons.play.addClass "btnDisabled"
      @update()

    onUpdate: ->
      @update()

    beforeClose: ->
      @list.remove()  if @list
      @list = null
      @buttons = {}
) jQuery