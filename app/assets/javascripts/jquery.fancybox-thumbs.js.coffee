#*!
# Thumbnail helper for fancyBox
# version: 1.0.2
# @requires fancyBox v2.0 or later
#
# Usage: 
#     $(".fancybox").fancybox({
#         thumbs: {
#             width	: 50,
#             height	: 50
#         }
#     });
# 
# Options:
#     width - thumbnail width
#     height - thumbnail height
#     source - function to obtain the URL of the thumbnail image
#     position - 'top' or 'bottom'
# 
#
(($) ->
  F = $.fancybox
  F.helpers.thumbs =
    wrap: null
    list: null
    width: 0
    source: (el) ->
      img = $(el).find("img")
      (if img.length then img.attr("src") else el.href)

    init: (opts) ->
      that = this
      list = undefined
      thumbWidth = opts.width or 50
      thumbHeight = opts.height or 50
      thumbSource = opts.source or @source
      list = ""
      n = 0

      while n < F.group.length
        list += "<li><a style=\"width:" + thumbWidth + "px;height:" + thumbHeight + "px;\" href=\"javascript:jQuery.fancybox.jumpto(" + n + ");\"></a></li>"
        n++
      @wrap = $("<div id=\"fancybox-thumbs\"></div>").addClass(opts.position or "bottom").appendTo("body")
      @list = $("<ul>" + list + "</ul>").appendTo(@wrap)
      $.each F.group, (i) ->
        $("<img />").load(->
          width = @width
          height = @height
          widthRatio = undefined
          heightRatio = undefined
          parent = undefined
          return  if not that.list or not width or not height
          widthRatio = width / thumbWidth
          heightRatio = height / thumbHeight
          parent = that.list.children().eq(i).find("a")
          if widthRatio >= 1 and heightRatio >= 1
            if widthRatio > heightRatio
              width = Math.floor(width / heightRatio)
              height = thumbHeight
            else
              width = thumbWidth
              height = Math.floor(height / widthRatio)
          $(this).css
            width: width
            height: height
            top: Math.floor(thumbHeight / 2 - height / 2)
            left: Math.floor(thumbWidth / 2 - width / 2)

          parent.width(thumbWidth).height thumbHeight
          $(this).hide().appendTo(parent).fadeIn 300
        ).attr "src", thumbSource(this)

      @width = @list.children().eq(0).outerWidth()
      @list.width(@width * (F.group.length + 1)).css "left", Math.floor($(window).width() * 0.5 - (F.current.index * @width + @width * 0.5))

    update: (opts) ->
      if @list
        @list.stop(true).animate
          left: Math.floor($(window).width() * 0.5 - (F.current.index * @width + @width * 0.5))
        , 150

    beforeLoad: (opts) ->
      if F.group.length < 2
        F.coming.helpers.thumbs = false
        return
      F.coming.margin[(if opts.position is "top" then 0 else 2)] = opts.height + 30

    afterShow: (opts) ->
      if @list
        @update opts
      else
        @init opts
      @list.children().removeClass("active").eq(F.current.index).addClass "active"

    onUpdate: ->
      @update()

    beforeClose: ->
      @wrap.remove()  if @wrap
      @wrap = null
      @list = null
      @width = 0
) jQuery