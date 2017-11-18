import SegmentElementBase from './base'
import $ from 'jquery'
import _ from 'lodash'

class MinuteSegment extends SegmentElementBase

  @tag 'tao-moment-picker-minute-segment'

  segmentName: 'minute'

  _bind: ->
    @on 'click', '.minute', (e) =>
      $minute = $ e.currentTarget
      momentData = _.clone @momentData
      momentData.minute = $minute.data 'minute'
      @namespacedTrigger 'dataSelect', [momentData]

  setMomentData: (momentData) ->
    super arguments...
    @_render()
    @momentData

  _render: ->
    @jq.find('.minute.selected').removeClass 'selected'
    unless _.isNil @value()
      @jq.find(".minute[data-minute='#{@value()}']").addClass 'selected'

export default MinuteSegment.register()
