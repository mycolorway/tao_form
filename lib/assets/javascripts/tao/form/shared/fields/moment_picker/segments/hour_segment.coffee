#= require ./base

MomentPicker = Tao.Form.MomentPicker

class MomentPicker.HourSegment extends MomentPicker.SegmentBase

  @tag 'tao-moment-picker-hour-segment'

  segmentName: 'hour'

  _bind: ->
    @on 'click', '.hour', (e) =>
      $hour = $ e.currentTarget
      momentData = _.clone @momentData
      momentData.hour = $hour.data 'hour'
      @namespacedTrigger 'dataSelect', [momentData]

  setMomentData: (momentData) ->
    super
    @_render()
    @momentData

  _render: ->
    @jq.find('.hour.selected').removeClass 'selected'
    unless _.isNil @value()
      @jq.find(".hour[data-hour='#{@value()}']").addClass 'selected'

TaoComponent.register MomentPicker.HourSegment
