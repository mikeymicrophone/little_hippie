#!
# fancyBox - jQuery Plugin
# version: 2.0.5 (21/02/2012)
# @requires jQuery v1.6 or later
#
# Examples at http://fancyapps.com/fancybox/
# License: www.fancyapps.com/fancybox/#license
#
# Copyright 2012 Janis Skarnelis - janis@fancyapps.com
#
#

((window, document, $) ->
  W = $(window)
  D = $(document)
  F = $.fancybox = ->
    F.open.apply this, arguments

  didResize = false
  resizeTimer = null
  isMobile = typeof document.createTouch isnt "undefined"
  $.extend F,
    version: "2.0.5"
    defaults:
      padding: 15
      margin: 20
      width: 800
      height: 600
      minWidth: 100
      minHeight: 100
      maxWidth: 9999
      maxHeight: 9999
      autoSize: true
      autoResize: not isMobile
      autoCenter: not isMobile
      fitToView: true
      aspectRatio: false
      topRatio: 0.5
      fixed: not ($.browser.msie and $.browser.version <= 6) and not isMobile
      scrolling: "auto"
      wrapCSS: "fancybox-default"
      arrows: true
      closeBtn: true
      closeClick: false
      nextClick: false
      mouseWheel: true
      autoPlay: false
      playSpeed: 3000
      preload: 3
      modal: false
      loop: true
      ajax:
        dataType: "html"
        headers:
          "X-fancyBox": true

      keys:
        next: [ 13, 32, 34, 39, 40 ]
        prev: [ 8, 33, 37, 38 ]
        close: [ 27 ]

      index: 0
      type: null
      href: null
      content: null
      title: null
      tpl:
        wrap: "<div class=\"fancybox-wrap\"><div class=\"fancybox-outer\"><div class=\"fancybox-inner\"></div></div></div>"
        image: "<img class=\"fancybox-image\" src=\"{href}\" alt=\"\" />"
        iframe: "<iframe class=\"fancybox-iframe\" name=\"fancybox-frame{rnd}\" frameborder=\"0\" hspace=\"0\"" + (if $.browser.msie then " allowtransparency=\"true\"" else "") + "></iframe>"
        swf: "<object classid=\"clsid:D27CDB6E-AE6D-11cf-96B8-444553540000\" width=\"100%\" height=\"100%\"><param name=\"wmode\" value=\"transparent\" /><param name=\"allowfullscreen\" value=\"true\" /><param name=\"allowscriptaccess\" value=\"always\" /><param name=\"movie\" value=\"{href}\" /><embed src=\"{href}\" type=\"application/x-shockwave-flash\" allowfullscreen=\"true\" allowscriptaccess=\"always\" width=\"100%\" height=\"100%\" wmode=\"transparent\"></embed></object>"
        error: "<p class=\"fancybox-error\">The requested content cannot be loaded.<br/>Please try again later.</p>"
        closeBtn: "<div title=\"Close\" class=\"fancybox-item fancybox-close\"></div>"
        next: "<a title=\"Next\" class=\"fancybox-nav fancybox-next\"><span></span></a>"
        prev: "<a title=\"Previous\" class=\"fancybox-nav fancybox-prev\"><span></span></a>"

      openEffect: "fade"
      openSpeed: 250
      openEasing: "swing"
      openOpacity: true
      openMethod: "zoomIn"
      closeEffect: "fade"
      closeSpeed: 250
      closeEasing: "swing"
      closeOpacity: true
      closeMethod: "zoomOut"
      nextEffect: "elastic"
      nextSpeed: 300
      nextEasing: "swing"
      nextMethod: "changeIn"
      prevEffect: "elastic"
      prevSpeed: 300
      prevEasing: "swing"
      prevMethod: "changeOut"
      helpers:
        overlay:
          speedIn: 0
          speedOut: 300
          opacity: 0.8
          css:
            cursor: "pointer"

          closeClick: true

        title:
          type: "float"

      onCancel: $.noop
      beforeLoad: $.noop
      afterLoad: $.noop
      beforeShow: $.noop
      afterShow: $.noop
      beforeClose: $.noop
      afterClose: $.noop

    group: {}
    opts: {}
    coming: null
    current: null
    isOpen: false
    isOpened: false
    wrap: null
    outer: null
    inner: null
    player:
      timer: null
      isActive: false

    ajaxLoad: null
    imgPreload: null
    transitions: {}
    helpers: {}
    open: (group, opts) ->
      F.close true
      group = (if group instanceof $ then $(group).get() else [ group ])  if group and not $.isArray(group)
      F.isActive = true
      F.opts = $.extend(true, {}, F.defaults, opts)
      F.opts.keys = (if opts.keys then $.extend({}, F.defaults.keys, opts.keys) else false)  if $.isPlainObject(opts) and typeof opts.keys isnt "undefined"
      F.group = group
      F._start F.opts.index or 0

    cancel: ->
      return  if F.coming and false is F.trigger("onCancel")
      F.coming = null
      F.hideLoading()
      F.ajaxLoad.abort()  if F.ajaxLoad
      F.ajaxLoad = null
      F.imgPreload.onload = F.imgPreload.onabort = F.imgPreload.onerror = null  if F.imgPreload

    close: (a) ->
      F.cancel()
      return  if not F.current or false is F.trigger("beforeClose")
      F.unbindEvents()
      if not F.isOpen or (a and a[0] is true)
        $(".fancybox-wrap").stop().trigger("onReset").remove()
        F._afterZoomOut()
      else
        F.isOpen = F.isOpened = false
        $(".fancybox-item, .fancybox-nav").remove()
        F.wrap.stop(true).removeClass "fancybox-opened"
        F.inner.css "overflow", "hidden"
        F.transitions[F.current.closeMethod]()

    play: (a) ->
      clear = ->
        clearTimeout F.player.timer

      set = ->
        clear()
        F.player.timer = setTimeout(F.next, F.current.playSpeed)  if F.current and F.player.isActive

      stop = ->
        clear()
        $("body").unbind ".player"
        F.player.isActive = false
        F.trigger "onPlayEnd"

      start = ->
        if F.current and (F.current.loop or F.current.index < F.group.length - 1)
          F.player.isActive = true
          $("body").bind
            "afterShow.player onUpdate.player": set
            "onCancel.player beforeClose.player": stop
            "beforeLoad.player": clear

          set()
          F.trigger "onPlayStart"

      if F.player.isActive or (a and a[0] is false)
        stop()
      else
        start()

    next: ->
      F.jumpto F.current.index + 1  if F.current

    prev: ->
      F.jumpto F.current.index - 1  if F.current

    jumpto: (index) ->
      return  unless F.current
      index = parseInt(index, 10)
      if F.group.length > 1 and F.current.loop
        if index >= F.group.length
          index = 0
        else index = F.group.length - 1  if index < 0
      if typeof F.group[index] isnt "undefined"
        F.cancel()
        F._start index

    reposition: (a) ->
      F.wrap.css F._getPosition(a)  if F.isOpen

    update: (e) ->
      if F.isOpen
        unless didResize
          resizeTimer = setTimeout(->
            current = F.current
            if didResize
              didResize = false
              if current
                if current.autoResize or (e and e.type is "orientationchange")
                  if current.autoSize
                    F.inner.height "auto"
                    current.height = F.inner.height()
                  F._setDimension()
                  F.inner.height "auto"  if current.canGrow
                F.reposition()  if current.autoCenter
                F.trigger "onUpdate"
          , 100)
        didResize = true

    toggle: ->
      if F.isOpen
        F.current.fitToView = not F.current.fitToView
        F.update()

    hideLoading: ->
      $("#fancybox-loading").remove()

    showLoading: ->
      F.hideLoading()
      $("<div id=\"fancybox-loading\"><div></div></div>").click(F.cancel).appendTo "body"

    getViewport: ->
      x: W.scrollLeft()
      y: W.scrollTop()
      w: W.width()
      h: W.height()

    unbindEvents: ->
      F.wrap.unbind ".fb"  if F.wrap
      D.unbind ".fb"
      W.unbind ".fb"

    bindEvents: ->
      current = F.current
      keys = current.keys
      return  unless current
      W.bind "resize.fb, orientationchange.fb", F.update
      if keys
        D.bind "keydown.fb", (e) ->
          code = undefined
          if not e.ctrlKey and not e.altKey and not e.shiftKey and not e.metaKey and $.inArray(e.target.tagName.toLowerCase(), [ "input", "textarea", "select", "button" ]) < 0
            code = e.keyCode
            if $.inArray(code, keys.close) > -1
              F.close()
              e.preventDefault()
            else if $.inArray(code, keys.next) > -1
              F.next()
              e.preventDefault()
            else if $.inArray(code, keys.prev) > -1
              F.prev()
              e.preventDefault()
      if $.fn.mousewheel and current.mouseWheel and F.group.length > 1
        F.wrap.bind "mousewheel.fb", (e, delta) ->
          target = $(e.target).get(0)
          if target.clientHeight is 0 or (target.scrollHeight is target.clientHeight and target.scrollWidth is target.clientWidth)
            e.preventDefault()
            F[(if delta > 0 then "prev" else "next")]()

    trigger: (event) ->
      ret = undefined
      obj = F[(if $.inArray(event, [ "onCancel", "beforeLoad", "afterLoad" ]) > -1 then "coming" else "current")]
      return  unless obj
      ret = obj[event].apply(obj, Array::slice.call(arguments, 1))  if $.isFunction(obj[event])
      return false  if ret is false
      if obj.helpers
        $.each obj.helpers, (helper, opts) ->
          F.helpers[helper][event] opts, obj  if opts and typeof F.helpers[helper] isnt "undefined" and $.isFunction(F.helpers[helper][event])
      $.event.trigger event + ".fb"

    isImage: (str) ->
      str and str.match(/\.(jpg|gif|png|bmp|jpeg)(.*)?$/i)

    isSWF: (str) ->
      str and str.match(/\.(swf)(.*)?$/i)

    _start: (index) ->
      coming = {}
      element = F.group[index] or null
      isDom = undefined
      href = undefined
      type = undefined
      rez = undefined
      if element and (element.nodeType or element instanceof $)
        isDom = true
        coming = $(element).metadata()  if $.metadata
      coming = $.extend(true, {}, F.opts,
        index: index
        element: element
      , (if $.isPlainObject(element) then element else coming))
      $.each [ "href", "title", "content", "type" ], (i, v) ->
        coming[v] = F.opts[v] or (isDom and $(element).attr(v)) or coming[v] or null

      coming.margin = [ coming.margin, coming.margin, coming.margin, coming.margin ]  if typeof coming.margin is "number"
      if coming.modal
        $.extend true, coming,
          closeBtn: false
          closeClick: false
          nextClick: false
          arrows: false
          mouseWheel: false
          keys: null
          helpers:
            overlay:
              css:
                cursor: "auto"

              closeClick: false
      F.coming = coming
      if false is F.trigger("beforeLoad")
        F.coming = null
        return
      type = coming.type
      href = coming.href or element
      unless type
        if isDom
          rez = $(element).data("fancybox-type")
          if not rez and element.className
            rez = element.className.match(/fancybox\.(\w+)/)
            type = (if rez then rez[1] else null)
        if not type and $.type(href) is "string"
          if F.isImage(href)
            type = "image"
          else if F.isSWF(href)
            type = "swf"
          else type = "inline"  if href.match(/^#/)
        type = (if isDom then "inline" else "html")  unless type
        coming.type = type
      if type is "inline" or type is "html"
        unless coming.content
          if type is "inline"
            coming.content = $((if $.type(href) is "string" then href.replace(/.*(?=#[^\s]+$)/, "") else href))
          else
            coming.content = element
        type = null  if not coming.content or not coming.content.length
      else type = null  unless href
      coming.group = F.group
      coming.isDom = isDom
      coming.href = href
      if type is "image"
        F._loadImage()
      else if type is "ajax"
        F._loadAjax()
      else if type
        F._afterLoad()
      else
        F._error "type"

    _error: (type) ->
      F.hideLoading()
      $.extend F.coming,
        type: "html"
        autoSize: true
        minHeight: 0
        hasError: type
        content: F.coming.tpl.error

      F._afterLoad()

    _loadImage: ->
      F.imgPreload = new Image()
      F.imgPreload.onload = ->
        @onload = @onerror = null
        F.coming.width = @width
        F.coming.height = @height
        F._afterLoad()

      F.imgPreload.onerror = ->
        @onload = @onerror = null
        F._error "image"

      F.imgPreload.src = F.coming.href
      F.showLoading()  unless F.imgPreload.width

    _loadAjax: ->
      F.showLoading()
      F.ajaxLoad = $.ajax($.extend({}, F.coming.ajax,
        url: F.coming.href
        error: (jqXHR, textStatus) ->
          if textStatus isnt "abort"
            F._error "ajax", jqXHR
          else
            F.hideLoading()

        success: (data, textStatus) ->
          if textStatus is "success"
            F.coming.content = data
            F._afterLoad()
      ))

    _preloadImages: ->
      group = F.group
      current = F.current
      len = group.length
      item = undefined
      href = undefined
      return  if not current.preload or group.length < 2
      i = 1

      while i <= Math.min(current.preload, len - 1)
        item = group[(current.index + i) % len]
        href = $(item).attr("href") or item
        new Image().src = href  if href
        i++

    _afterLoad: ->
      F.hideLoading()
      if not F.coming or false is F.trigger("afterLoad", F.current)
        F.coming = false
        return
      if F.isOpened
        $(".fancybox-item").remove()
        F.wrap.stop(true).removeClass "fancybox-opened"
        F.inner.css "overflow", "hidden"
        F.transitions[F.current.prevMethod]()
      else
        $(".fancybox-wrap").stop().trigger("onReset").remove()
        F.trigger "afterClose"
      F.unbindEvents()
      F.isOpen = false
      F.current = F.coming
      F.wrap = $(F.current.tpl.wrap).addClass("fancybox-" + (if isMobile then "mobile" else "desktop") + " fancybox-tmp " + F.current.wrapCSS).appendTo("body")
      F.outer = $(".fancybox-outer", F.wrap).css("padding", F.current.padding + "px")
      F.inner = $(".fancybox-inner", F.wrap)
      F._setContent()

    _setContent: ->
      content = undefined
      loadingBay = undefined
      iframe = undefined
      current = F.current
      type = current.type
      switch type
        when "inline", "ajax", "html"
          content = current.content
          if content instanceof $
            content = content.show().detach()
            content.parents(".fancybox-wrap").trigger("onReset").remove()  if content.parent().hasClass("fancybox-inner")
            $(F.wrap).bind "onReset", ->
              content.appendTo("body").hide()
          if current.autoSize
            loadingBay = $("<div class=\"fancybox-tmp " + F.current.wrapCSS + "\"></div>").appendTo("body").append(content)
            current.width = loadingBay.width()
            current.height = loadingBay.height()
            loadingBay.width F.current.width
            if loadingBay.height() > current.height
              loadingBay.width current.width + 1
              current.width = loadingBay.width()
              current.height = loadingBay.height()
            content = loadingBay.contents().detach()
            loadingBay.remove()
        when "image"
          content = current.tpl.image.replace("{href}", current.href)
          current.aspectRatio = true
        when "swf"
          content = current.tpl.swf.replace(/\{width\}/g, current.width).replace(/\{height\}/g, current.height).replace(/\{href\}/g, current.href)
      if type is "iframe"
        content = $(current.tpl.iframe.replace("{rnd}", new Date().getTime())).attr("scrolling", current.scrolling)
        current.scrolling = "auto"
        if current.autoSize
          content.width current.width
          F.showLoading()
          content.data("ready", false).appendTo(F.inner).bind(
            onCancel: ->
              $(this).unbind()
              F._afterZoomOut()

            load: ->
              iframe = $(this)
              height = undefined
              try
                if @contentWindow.document.location
                  height = iframe.contents().find("body").height() + 12
                  iframe.height height
              catch e
                current.autoSize = false
              if iframe.data("ready") is false
                F.hideLoading()
                F.current.height = height  if height
                F._beforeShow()
                iframe.data "ready", true
              else F.update()  if height
          ).attr "src", current.href
          return
        else
          content.attr "src", current.href
      else if type is "image" or type is "swf"
        current.autoSize = false
        current.scrolling = "visible"
      F.inner.append content
      F._beforeShow()

    _beforeShow: ->
      F.coming = null
      F.trigger "beforeShow"
      F._setDimension()
      F.wrap.hide().removeClass "fancybox-tmp"
      F.bindEvents()
      F._preloadImages()
      F.transitions[(if F.isOpened then F.current.nextMethod else F.current.openMethod)]()

    _setDimension: ->
      wrap = F.wrap
      outer = F.outer
      inner = F.inner
      current = F.current
      viewport = F.getViewport()
      margin = current.margin
      padding2 = current.padding * 2
      width = current.width
      height = current.height
      maxWidth = current.maxWidth
      maxHeight = current.maxHeight
      minWidth = current.minWidth
      minHeight = current.minHeight
      ratio = undefined
      height_ = undefined
      space = undefined
      viewport.w -= (margin[1] + margin[3])
      viewport.h -= (margin[0] + margin[2])
      width = ((viewport.w - padding2) * parseFloat(width) / 100)  if width.toString().indexOf("%") > -1
      height = ((viewport.h - padding2) * parseFloat(height) / 100)  if height.toString().indexOf("%") > -1
      ratio = width / height
      width += padding2
      height += padding2
      if current.fitToView
        maxWidth = Math.min(viewport.w, maxWidth)
        maxHeight = Math.min(viewport.h, maxHeight)
      if current.aspectRatio
        if width > maxWidth
          width = maxWidth
          height = ((width - padding2) / ratio) + padding2
        if height > maxHeight
          height = maxHeight
          width = ((height - padding2) * ratio) + padding2
        if width < minWidth
          width = minWidth
          height = ((width - padding2) / ratio) + padding2
        if height < minHeight
          height = minHeight
          width = ((height - padding2) * ratio) + padding2
      else
        width = Math.max(minWidth, Math.min(width, maxWidth))
        height = Math.max(minHeight, Math.min(height, maxHeight))
      width = Math.round(width)
      height = Math.round(height)
      $(wrap.add(outer).add(inner)).width("auto").height "auto"
      inner.width(width - padding2).height height - padding2
      wrap.width width
      height_ = wrap.height()
      if width > maxWidth or height_ > maxHeight
        while (width > maxWidth or height_ > maxHeight) and width > minWidth and height_ > minHeight
          height = height - 10
          if current.aspectRatio
            width = Math.round(((height - padding2) * ratio) + padding2)
            if width < minWidth
              width = minWidth
              height = ((width - padding2) / ratio) + padding2
          else
            width = width - 10
          inner.width(width - padding2).height height - padding2
          wrap.width width
          height_ = wrap.height()
      current.dim =
        width: width
        height: height_

      current.canGrow = current.autoSize and height > minHeight and height < maxHeight
      current.canShrink = false
      current.canExpand = false
      if (width - padding2) < current.width or (height - padding2) < current.height
        current.canExpand = true
      else current.canShrink = true  if (width > viewport.w or height_ > viewport.h) and width > minWidth and height > minHeight
      space = height_ - padding2
      F.innerSpace = space - inner.height()
      F.outerSpace = space - outer.height()

    _getPosition: (a) ->
      current = F.current
      viewport = F.getViewport()
      margin = current.margin
      width = F.wrap.width() + margin[1] + margin[3]
      height = F.wrap.height() + margin[0] + margin[2]
      rez =
        position: "absolute"
        top: margin[0] + viewport.y
        left: margin[3] + viewport.x

      if current.fixed and (not a or a[0] is false) and height <= viewport.h and width <= viewport.w
        rez =
          position: "fixed"
          top: margin[0]
          left: margin[3]
      rez.top = Math.ceil(Math.max(rez.top, rez.top + ((viewport.h - height) * current.topRatio))) + "px"
      rez.left = Math.ceil(Math.max(rez.left, rez.left + ((viewport.w - width) * 0.5))) + "px"
      rez

    _afterZoomIn: ->
      current = F.current
      scrolling = current.scrolling
      F.isOpen = F.isOpened = true
      F.wrap.addClass("fancybox-opened").css "overflow", "visible"
      F.update()
      F.inner.css "overflow", (if scrolling is "yes" then "scroll" else (if scrolling is "no" then "hidden" else scrolling))
      F.inner.css("cursor", "pointer").bind "click.fb", (if current.nextClick then F.next else F.close)  if current.closeClick or current.nextClick
      $(current.tpl.closeBtn).appendTo(F.outer).bind "click.fb", F.close  if current.closeBtn
      if current.arrows and F.group.length > 1
        $(current.tpl.prev).appendTo(F.inner).bind "click.fb", F.prev  if current.loop or current.index > 0
        $(current.tpl.next).appendTo(F.inner).bind "click.fb", F.next  if current.loop or current.index < F.group.length - 1
      F.trigger "afterShow"
      if F.opts.autoPlay and not F.player.isActive
        F.opts.autoPlay = false
        F.play()

    _afterZoomOut: ->
      F.trigger "afterClose"
      F.wrap.trigger("onReset").remove()
      $.extend F,
        group: {}
        opts: {}
        current: null
        isActive: false
        isOpened: false
        isOpen: false
        wrap: null
        outer: null
        inner: null

  F.transitions =
    getOrigPosition: ->
      current = F.current
      element = current.element
      padding = current.padding
      orig = $(current.orig)
      pos = {}
      width = 50
      height = 50
      viewport = undefined
      if not orig.length and current.isDom and $(element).is(":visible")
        orig = $(element).find("img:first")
        orig = $(element)  unless orig.length
      if orig.length
        pos = orig.offset()
        if orig.is("img")
          width = orig.outerWidth()
          height = orig.outerHeight()
      else
        viewport = F.getViewport()
        pos.top = viewport.y + (viewport.h - height) * 0.5
        pos.left = viewport.x + (viewport.w - width) * 0.5
      pos =
        top: Math.ceil(pos.top - padding) + "px"
        left: Math.ceil(pos.left - padding) + "px"
        width: Math.ceil(width + padding * 2) + "px"
        height: Math.ceil(height + padding * 2) + "px"

      pos

    step: (now, fx) ->
      ratio = undefined
      innerValue = undefined
      outerValue = undefined
      if fx.prop is "width" or fx.prop is "height"
        innerValue = outerValue = Math.ceil(now - (F.current.padding * 2))
        if fx.prop is "height"
          ratio = (now - fx.start) / (fx.end - fx.start)
          ratio = 1 - ratio  if fx.start > fx.end
          innerValue -= F.innerSpace * ratio
          outerValue -= F.outerSpace * ratio
        F.inner[fx.prop] innerValue
        F.outer[fx.prop] outerValue

    zoomIn: ->
      wrap = F.wrap
      current = F.current
      startPos = undefined
      endPos = undefined
      dim = current.dim
      if current.openEffect is "elastic"
        endPos = $.extend({}, dim, F._getPosition(true))
        delete endPos.position

        startPos = @getOrigPosition()
        if current.openOpacity
          startPos.opacity = 0
          endPos.opacity = 1
        F.outer.add(F.inner).width("auto").height "auto"
        wrap.css(startPos).show()
        wrap.animate endPos,
          duration: current.openSpeed
          easing: current.openEasing
          step: @step
          complete: F._afterZoomIn
      else
        wrap.css $.extend({}, dim, F._getPosition())
        if current.openEffect is "fade"
          wrap.fadeIn current.openSpeed, F._afterZoomIn
        else
          wrap.show()
          F._afterZoomIn()

    zoomOut: ->
      wrap = F.wrap
      current = F.current
      endPos = undefined
      if current.closeEffect is "elastic"
        wrap.css F._getPosition(true)  if wrap.css("position") is "fixed"
        endPos = @getOrigPosition()
        endPos.opacity = 0  if current.closeOpacity
        wrap.animate endPos,
          duration: current.closeSpeed
          easing: current.closeEasing
          step: @step
          complete: F._afterZoomOut
      else
        wrap.fadeOut (if current.closeEffect is "fade" then current.closeSpeed else 0), F._afterZoomOut

    changeIn: ->
      wrap = F.wrap
      current = F.current
      startPos = undefined
      if current.nextEffect is "elastic"
        startPos = F._getPosition(true)
        startPos.opacity = 0
        startPos.top = (parseInt(startPos.top, 10) - 200) + "px"
        wrap.css(startPos).show().animate
          opacity: 1
          top: "+=200px"
        ,
          duration: current.nextSpeed
          easing: current.nextEasing
          complete: F._afterZoomIn
      else
        wrap.css F._getPosition()
        if current.nextEffect is "fade"
          wrap.hide().fadeIn current.nextSpeed, F._afterZoomIn
        else
          wrap.show()
          F._afterZoomIn()

    changeOut: ->
      wrap = F.wrap
      current = F.current
      cleanUp = ->
        $(this).trigger("onReset").remove()

      wrap.removeClass "fancybox-opened"
      if current.prevEffect is "elastic"
        wrap.animate
          opacity: 0
          top: "+=200px"
        ,
          duration: current.prevSpeed
          easing: current.prevEasing
          complete: cleanUp
      else
        wrap.fadeOut (if current.prevEffect is "fade" then current.prevSpeed else 0), cleanUp

  F.helpers.overlay =
    overlay: null
    update: ->
      width = undefined
      scrollWidth = undefined
      offsetWidth = undefined
      @overlay.width(0).height 0
      if $.browser.msie
        scrollWidth = Math.max(document.documentElement.scrollWidth, document.body.scrollWidth)
        offsetWidth = Math.max(document.documentElement.offsetWidth, document.body.offsetWidth)
        width = (if scrollWidth < offsetWidth then W.width() else scrollWidth)
      else
        width = D.width()
      @overlay.width(width).height D.height()

    beforeShow: (opts) ->
      return  if @overlay
      opts = $.extend(true,
        speedIn: "fast"
        closeClick: true
        opacity: 1
        css:
          background: "black"
      , opts)
      @overlay = $("<div id=\"fancybox-overlay\"></div>").css(opts.css).appendTo("body")
      @update()
      @overlay.bind "click.fb", F.close  if opts.closeClick
      W.bind "resize.fb", $.proxy(@update, this)
      @overlay.fadeTo opts.speedIn, opts.opacity

    onUpdate: ->
      @update()

    afterClose: (opts) ->
      if @overlay
        @overlay.fadeOut opts.speedOut or 0, ->
          $(this).remove()
      @overlay = null

  F.helpers.title = beforeShow: (opts) ->
    title = undefined
    text = F.current.title
    if text
      title = $("<div class=\"fancybox-title fancybox-title-" + opts.type + "-wrap\">" + text + "</div>").appendTo("body")
      if opts.type is "float"
        title.width title.width()
        title.wrapInner "<span class=\"child\"></span>"
        F.current.margin[2] += Math.abs(parseInt(title.css("margin-bottom"), 10))
      title.appendTo (if opts.type is "over" then F.inner else (if opts.type is "outside" then F.wrap else F.outer))

  $.fn.fancybox = (options) ->
    that = $(this)
    selector = @selector or ""
    index = undefined
    run = (e) ->
      what = this
      relType = "rel"
      relVal = what[relType]
      idx = index
      unless e.ctrlKey or e.altKey or e.shiftKey or e.metaKey
        e.preventDefault()
        unless relVal
          relType = "data-fancybox-group"
          relVal = $(what).attr("data-fancybox-group")
        if relVal and relVal isnt "" and relVal isnt "nofollow"
          what = (if selector.length then $(selector) else that)
          what = what.filter("[" + relType + "=\"" + relVal + "\"]")
          idx = what.index(this)
        options.index = idx
        F.open what, options

    options = options or {}
    index = options.index or 0
    if selector
      D.undelegate(selector, "click.fb-start").delegate selector, "click.fb-start", run
    else
      that.unbind("click.fb-start").bind "click.fb-start", run
    this
) window, document, jQuery