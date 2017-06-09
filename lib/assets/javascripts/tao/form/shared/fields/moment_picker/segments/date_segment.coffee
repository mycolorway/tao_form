#= require ./base

MomentPicker = Tao.Form.MomentPicker

class MomentPicker.DateSegment extends MomentPicker.SegmentBase

  @tag 'tao-moment-picker-date-segment'

  segmentName: 'date'

  dateFormat: 'YYYY-MM-DD'

  _connected: ->
    super
    @momentData = {}
    @_renderWeekdays()

  _bind: ->
    @on 'click', '.day', (e) =>
      $day = $ e.currentTarget
      date = moment $day.data('date'), @dateFormat
      momentData = _.clone @momentData
      momentData.year = date.year()
      momentData.month = date.month()
      momentData.date = date.date()
      @trigger 'dataSelect', [momentData]

    @on 'click', '.link-prev-month, .link-next-month', (e) =>
      month = if $(e.currentTarget).is('.link-prev-month')
        moment(@momentData).subtract(1, 'month')
      else
        moment(@momentData).add(1, 'month')

      momentData = _.clone @momentData
      momentData.year = month.year()
      momentData.month = month.month()
      momentData.date = null
      @trigger 'dataRefresh', [momentData]

  setMomentData: (momentData) ->
    if @active && (_.isNil(momentData['year']) || _.isNil(momentData['month']))
      now = moment()
      momentData.year = now.year()
      momentData.month = now.month()
      momentData.date = null
      @trigger 'dataRefresh', [momentData]
      return false
    else if @momentData && momentData &&
        momentData['year'] == @momentData['year'] &&
        momentData['month'] == @momentData['month']
      @_renderDate momentData
    else
      @_renderCalendar momentData

    super

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

      weekdays = ['sun', 'mon', 'tue', 'wed', 'thu', 'fri', 'sat']
      $day.addClass weekdays[startDate.day()]
        .appendTo $days
      startDate.add 1, 'days'

  _renderWeekdays: ->
    $head = @jq.find('.weekdays')
    $.each moment.weekdaysMin(true), (i, weekdayName) ->
      $('<span>', class: 'weekday', text: weekdayName)
        .appendTo $head


TaoComponent.register MomentPicker.DateSegment
