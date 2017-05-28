#= require ./base

class Tao.Form.Select.Element extends Tao.Form.Select.ElementBase

  _disconnected: ->
    super
    @_unbindDocumentMousedown()

  _bindResultEvents: ->
    super

    @on 'enterPress', '.select-result', (e) =>
      if @active
        if @selectOption @list.highlightedOption
          @trigger 'change', @selectedOption
      else
        @active = true
      null

    @on 'arrowPress', '.select-result', (e, direction) =>
      if @active
        if direction == 'up'
          @list.highlightPrevOption()
        else
          @list.highlightNextOption()
      else
        @active = true
      null

  _bindListEvents: ->
    super

    @on 'selectOption', '.select-list', (e, option) =>
      @active = false
      null

    @on 'show', '.select-list', (e) =>
      @_positionList()

    @on 'searchEscapePress', '.select-list', (e) =>
      @active = false
      null

  _activeChanged: ->
    @list.active = @active
    @result.active = @active

    @_unbindDocumentMousedown()
    if @active
      @_bindDocumentMousedown()
    else
      @result.focus()

  _unbindDocumentMousedown: ->
    $(document).off "mousedown.tao-select-#{@taoId}"

  _bindDocumentMousedown: ->
    $(document).on "mousedown.tao-select-#{@taoId}", (e) =>
      return if $.contains(@, e.target) && !(@multiple && @result == e.target)
      @active = false
      @_unbindDocumentMousedown()

  _positionList: ->
    rect = @getBoundingClientRect()
    offsetToWindowTop = rect.top
    offsetToWindowBottom = $(window).height() - rect.bottom

    @list.setMaxHeight false
    @_reflow()
    listHeight = @list.jq.outerHeight()

    if offsetToWindowBottom < listHeight && offsetToWindowTop > offsetToWindowBottom
      @list.setMaxHeight offsetToWindowTop - 20
      @list.direction = 'up'
    else
      @list.setMaxHeight(offsetToWindowBottom - 20) if offsetToWindowBottom < listHeight
      @list.direction = 'down'

TaoComponent.register Tao.Form.Select.Element
