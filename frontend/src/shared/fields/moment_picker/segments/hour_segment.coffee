import SegmentElementBase from './base'
import $ from 'jquery'
import _ from 'lodash'

class HourSegment extends SegmentElementBase

  @tag 'tao-moment-picker-hour-segment'

  segmentName: 'hour'

  _bind: ->
    @on 'click', '.hour', (e) =>
      $hour = $ e.currentTarget
      momentData = _.clone @momentData
      momentData.hour = $hour.data 'hour'
      @namespacedTrigger 'dataSelect', [momentData]

  setMomentData: (momentData) ->
    super arguments...
    @_render()
    @momentData

  _render: ->
    @jq.find('.hour.selected').removeClass 'selected'
    unless _.isNil @value()
      @jq.find(".hour[data-hour='#{@value()}']").addClass 'selected'

export default HourSegment.register()
