
class Tao.Form.DatetimePicker extends TaoComponent

  @tag 'tao-datetime-picker'

  @attribute 'valueFormat', default: 'YYYY-MM-DDTHH:mm:ss'

  @attribute 'dateValueFormat', default: 'YYYY-MM-DD'

  @attribute 'dateDisplayFormat', default: 'YYYY-MM-DD'

  @attribute 'timeValueFormat', default: 'HH:mm'

  @attribute 'timeDisplayFormat', default: 'HH:mm'

  _connected: ->
    @field = @jq.find '> input'
    @datePicker = @findComponent 'tao-date-picker'
    @timePicker = @findComponent 'tao-time-picker'
    @_bind()

  _disconnected: ->
    @off()

  _bind: ->
    @on 'tao:change', '.tao-moment-picker', (e, m) =>
      @_syncMoment()
      @trigger 'tao:change', [@moment]

    datePickerDeferred = $.Deferred()
    timePickerDeferred = $.Deferred()

    @on 'tao:ready', 'tao-date-picker', ->
      datePickerDeferred.resolve()

    @on 'tao:ready', 'tao-time-picker', ->
      timePickerDeferred.resolve()

    $.when(datePickerDeferred, timePickerDeferred).done =>
      @_initMoment()
      @trigger 'tao:ready'

  _initMoment: ->
    m = moment @field.val(), @valueFormat

    if m && m.isValid()
      @datePicker.setMoment m.format(@dateValueFormat)
      @timePicker.setMoment m.format(@timeValueFormat)
      @moment = m
    else
      @moment = null

  _syncMoment: ->
    if @datePicker.moment
      dateValue = @datePicker.moment.format(@dateValueFormat)
      timeValue = if @timePicker.moment
        @timePicker.moment.format(@timeValueFormat)
      else
        moment().startOf('day').format(@timeValueFormat)

      value = _.trim "#{dateValue} #{timeValue}"
      m = moment value, "#{@dateValueFormat} #{@timeValueFormat}"
      @field.val m.format(@valueFormat)
      @moment = m
    else
      @field.val ''
      @moment = null

TaoComponent.register Tao.Form.DatetimePicker
