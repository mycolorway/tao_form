import SegmentElementBase from './base'
import $ from 'jquery'
import moment from 'moment'
import _ from 'lodash'

class DateSegment extends SegmentElementBase

  @tag 'tao-moment-picker-date-segment'

  segmentName: 'date'

  dateFormat: 'YYYY-MM-DD'

  _init: ->
    super()
    @_renderWeekdays()

  _connected: ->
    super()
    @momentData = {}

  _bind: ->
    @on 'click', '.day', (e) =>
      $day = $ e.currentTarget
      return if $day.hasClass('disabled')
      date = moment $day.data('date'), @dateFormat
      momentData = _.clone @momentData
      momentData.year = date.year()
      momentData.month = date.month()
      momentData.date = date.date()
      @namespacedTrigger 'dataSelect', [momentData]

    @on 'click', '.link-prev-month, .link-next-month', (e) =>
      month = if $(e.currentTarget).is('.link-prev-month')
        moment(@momentData).subtract(1, 'month')
      else
        moment(@momentData).add(1, 'month')

      momentData = _.clone @momentData
      momentData.year = month.year()
      momentData.month = month.month()
      momentData.date = null
      @namespacedTrigger 'dataRefresh', [momentData]

  setMomentData: (momentData) ->
    if @active && (_.isNil(momentData['year']) || _.isNil(momentData['month']))
      now = moment()
      momentData.year = now.year()
      momentData.month = now.month()
      momentData.date = null
      @namespacedTrigger 'dataRefresh', [momentData]
      return false
    else if @momentData && momentData &&
        momentData['year'] == @momentData['year'] &&
        momentData['month'] == @momentData['month']
      @_renderDate momentData
    else
      @_renderCalendar momentData

    super arguments...

  _renderDate: (momentData = @momentData) ->
    @jq.find('.day.selected').removeClass('selected')

    date = moment(momentData)
    return if _.isNil(momentData[@segmentName]) || !date.isValid()
    @jq.find(".day[data-date='#{date.format(@dateFormat)}']")
      .addClass('selected')

  _renderCalendar: (momentData = @momentData) ->
    $days = @jq.find('.days').empty()
    date = moment(momentData).startOf('day')
    startDate = date.clone().startOf('month').startOf('week')
    endDate = date.clone().endOf('month').endOf('week')
    while startDate.isSameOrBefore(endDate)
      $day = $ '<a>',
        href: 'javascript:;'
        class: 'day'
        'data-date': startDate.format(@dateFormat)
        text: startDate.format('D')

      $day.addClass('outside') unless startDate.month() == date.month()
      $day.addClass('today') if startDate.isSame(moment().startOf('day'))
      if startDate.date() == momentData['date'] &&
          startDate.month() == momentData['month']
        $day.addClass('selected')
      if (@disableBefore && startDate.isSameOrBefore(@disableBefore)) ||
          (@disableAfter && startDate.isSameOrAfter(@disableAfter))
        $day.addClass('disabled')

      weekdays = ['sun', 'mon', 'tue', 'wed', 'thu', 'fri', 'sat']
      $day.addClass weekdays[startDate.day()]
        .appendTo $days
      startDate.add 1, 'days'

  _renderWeekdays: ->
    $head = @jq.find('.weekdays').empty()
    $.each moment.weekdaysMin(true), (i, weekdayName) ->
      $('<span>', class: 'weekday', text: weekdayName)
        .appendTo $head

  _disableBeforeChanged: ->
    @_renderCalendar()

  _disableAfterChanged: ->
    @_renderCalendar()

export default DateSegment.register()
