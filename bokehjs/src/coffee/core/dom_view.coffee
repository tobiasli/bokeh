import {View} from "./view"
import * as DOM from "./dom"

import {defer} from "./util/callback"

export class DOMView extends View

  tagName: 'div'

  initialize: (options) ->
    super(options)
    @el = @_createElement()

  remove: () ->
    DOM.removeElement(@el)
    super()

  layout: () ->

  render: () ->

  renderTo: (element, replace=false) -> # HTMLElement, boolean
    if not replace
      element.appendChild(@el)
    else
      DOM.replaceWith(element, @el)

    # XXX: need to defer to allow idle callback to be set
    defer(() => @layout())

  @getters {
    solver:  () -> if @is_root then @_solver else @parent.solver
  }

  _createElement: () ->
    return DOM.createElement(@tagName, {id: @id, class: @className})
