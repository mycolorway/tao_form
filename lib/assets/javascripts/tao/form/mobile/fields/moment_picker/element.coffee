#= require tao/form/shared/fields/moment_picker/element/base

class Tao.Form.MomentPicker.Element extends Tao.Form.MomentPicker.ElementBase

  _connected: ->
    @slideBox = @findComponent '.slide-box'
    super

  _bind: ->
    super

    @slideBox.on 'tao:hide', (e) =>
      @active = false if @active
      null

    @on 'click', '.header .link-close', (e) =>
      @active = false
      null

    @on 'click', '.header .button-confirm', (e) =>
      @active = false
      @setMoment moment(@segmentList.momentData)
      null

    @on 'tao:clear', '.tao-moment-picker-segment-list', (e) =>
      return if @disabled
      @active = false
      @setMoment null
      @trigger 'tao:change', [@moment]
      null

  _activeChanged: ->
    @slideBox.active = @active
    if @active
      @segmentList.setMoment @moment
      @segmentList.clearable = !!@moment
      @segmentList.refreshHeight()


TaoComponent.register Tao.Form.MomentPicker.Element
