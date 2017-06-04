#= require ./base

class Tao.Form.MomentPicker.Element extends Tao.Form.MomentPicker.ElementBase

  _bind: ->
    super

    @on 'show', 'tao-moment-picker-segment-list', (e) =>
      @_positionList()

  _activeChanged: ->
    @result.active = @active
    @segmentList.active = @active

    @_unbindDocumentMousedown()
    if @active
      @segmentList.setMoment(@moment)
      @_bindDocumentMousedown()

  _unbindDocumentMousedown: ->
    $(document).off "mousedown.tao-moment-picker-#{@taoId}"

  _bindDocumentMousedown: ->
    $(document).on "mousedown.tao-moment-picker-#{@taoId}", (e) =>
      return if $.contains(@, e.target) && !(@multiple && @result == e.target)
      @active = false
      @_unbindDocumentMousedown()

  _positionList: ->
    rect = @getBoundingClientRect()
    offsetToWindowTop = rect.top
    offsetToWindowBottom = $(window).height() - rect.bottom
    listHeight = @segmentList.jq.outerHeight()

    @segmentList.direction = if offsetToWindowBottom < listHeight && offsetToWindowTop > offsetToWindowBottom
      'up'
    else
      'down'
