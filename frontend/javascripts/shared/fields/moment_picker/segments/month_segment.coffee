import SegmentElementBase from './base'
import $ from 'jquery'
import _ from 'lodash'
import moment from 'moment'

class MonthSegment extends SegmentElementBase

  @tag 'tao-moment-picker-month-segment'

  segmentName: 'month'

  _bind: ->
    @on 'click', '.month', (e) =>
      $month = $ e.currentTarget
      momentData = _.clone @momentData
      momentData.month = $month.data 'month'
      momentData.date = null
      @namespacedTrigger 'dataSelect', [momentData]

    @on 'click', '.link-prev-year, .link-next-year', (e) =>
      momentData = _.clone @momentData
      if $(e.currentTarget).is('.link-prev-year')
        momentData['year'] -= 1
      else
        momentData['year'] += 1
      momentData.date = null
      @namespacedTrigger 'dataRefresh', [momentData]

  setMomentData: (momentData) ->
    super arguments...
    @_render()
    @momentData

  _render: ->
    @jq.find('.month.selected').removeClass 'selected'
    @jq.find('.month.current').removeClass 'current'
    unless _.isNil @value()
      @jq.find(".month[data-month='#{@value()}']").addClass 'selected'

    now = moment()
    if @momentData['year'] == now.year()
      @jq.find(".month[data-month='#{now.month()}']").addClass 'current'

  label: ->
    moment.monthsShort()[@value() * 1]

export default MonthSegment.register()
