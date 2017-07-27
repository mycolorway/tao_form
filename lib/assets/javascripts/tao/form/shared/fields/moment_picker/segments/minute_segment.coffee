#= require ./base

MomentPicker = Tao.Form.MomentPicker

class MomentPicker.MinuteSegment extends MomentPicker.SegmentBase

  @tag 'tao-moment-picker-minute-segment'

  segmentName: 'minute'

  _bind: ->
    @on 'click', '.minute', (e) =>
      $minute = $ e.currentTarget
      momentData = _.clone @momentData
      momentData.minute = $minute.data 'minute'
      @namespacedTrigger 'dataSelect', [momentData]

  setMomentData: (momentData) ->
    super
    @_render()
    @momentData

  _render: ->
    @jq.find('.minute.selected').removeClass 'selected'
    unless _.isNil @value()
      @jq.find(".minute[data-minute='#{@value()}']").addClass 'selected'

TaoComponent.register MomentPicker.MinuteSegment
