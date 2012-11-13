#! Copyright (c) 2011 Brandon Aaron (http://brandonaaron.net)
# Licensed under the MIT License (LICENSE.txt).
#
# Thanks to: http://adomas.org/javascript-mouse-wheel/ for some pointers.
# Thanks to: Mathias Bank(http://www.mathias-bank.de) for a scope bug fix.
# Thanks to: Seamus Leahy for adding deltaX and deltaY
#
# Version: 3.0.6
# 
# Requires: 1.2.2+
#
((d) ->
  e = (a) ->
    b = a or window.event
    c = [].slice.call(arguments, 1)
    f = 0
    e = 0
    g = 0
    a = d.event.fix(b)
    a.type = "mousewheel"
    b.wheelDelta and (f = b.wheelDelta / 120)
    b.detail and (f = -b.detail / 3)
    g = f
    b.axis isnt undefined and b.axis is b.HORIZONTAL_AXIS and (g = 0
    e = -1 * f
    )
    b.wheelDeltaY isnt undefined and (g = b.wheelDeltaY / 120)
    b.wheelDeltaX isnt undefined and (e = -1 * b.wheelDeltaX / 120)
    c.unshift a, f, e, g
    (d.event.dispatch or d.event.handle).apply this, c
  c = [ "DOMMouseScroll", "mousewheel" ]
  if d.event.fixHooks
    h = c.length

    while h
      d.event.fixHooks[c[--h]] = d.event.mouseHooks
  d.event.special.mousewheel =
    setup: ->
      if @addEventListener
        a = c.length

        while a
          @addEventListener c[--a], e, false
      else
        @onmousewheel = e

    teardown: ->
      if @removeEventListener
        a = c.length

        while a
          @removeEventListener c[--a], e, false
      else
        @onmousewheel = null

  d.fn.extend
    mousewheel: (a) ->
      (if a then @bind("mousewheel", a) else @trigger("mousewheel"))

    unmousewheel: (a) ->
      @unbind "mousewheel", a
) jQuery