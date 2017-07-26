class Tao.Form.DateRangePicker extends TaoComponent

  @tag 'tao-date-range-picker'

  @attribute 'dateValueFormat', default: 'YYYY-MM-DD'

  @attribute 'dateDisplayFormat', default: 'YYYY-MM-DD'

  @get 'value', ->
    @field?.val()

  _connected: ->
    @field = @jq.find '> input'
    @startDatePicker = @findComponent '.start-date-picker'
    @endDatePicker = @findComponent '.end-date-picker'
    @_bind()

  _disconnected: ->
    @off()

  _bind: ->
    @on 'tao:change', '.tao-moment-picker', (e, m) =>
      datePicker = e.currentTarget
      if datePicker == @startDatePicker
        @endDatePicker.disableBefore datePicker.moment
      else
        @startDatePicker.disableAfter datePicker.moment
      @_syncMoment()
      @trigger 'tao:change', [@field.val()]

    startDatePickerDeferred = $.Deferred()
    endDatePickerDeferred = $.Deferred()

    @on 'tao:ready', '.start-date-picker', ->
      startDatePickerDeferred.resolve()

    @on 'tao:ready', '.end-date-picker', ->
      endDatePickerDeferred.resolve()

    $.when(startDatePickerDeferred, endDatePickerDeferred).done =>
      @_initMoment()
      @trigger 'tao:ready'

  _initMoment: ->
    dates = @field.val().split(',')

    if dates.length > 0
      @startDate = moment _.trim(dates[0]), @dateValueFormat
      @endDate = moment _.trim(dates[1]), @dateValueFormat
      @startDatePicker.setMoment @startDate.clone()
      @endDatePicker.setMoment @endDate.clone()
    else
      @startDate = null
      @endDate = null

  _syncMoment: ->
    if @startDatePicker.moment && @endDatePicker.moment
      startDateValue = @startDatePicker.moment.format(@dateValueFormat)
      endDateValue = @endDatePicker.moment.format(@dateValueFormat)

      @field.val "#{startDateValue},#{endDateValue}"
      @startDate = @startDatePicker.moment.clone()
      @endDate = @endDatePicker.moment.clone()
    else
      @field.val ''
      @startDate = null
      @endDate = null

TaoComponent.register Tao.Form.DateRangePicker
