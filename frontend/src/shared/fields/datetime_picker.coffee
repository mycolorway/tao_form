import { Component } from '@mycolorway/tao'
import $ from 'jquery'
import _ from 'lodash'
import moment from 'moment'

class DateTimePickerElement extends Component

  @tag 'tao-datetime-picker'

  @attribute 'valueFormat', default: 'YYYY-MM-DDTHH:mm:ss'

  @attribute 'dateValueFormat', default: 'YYYY-MM-DD'

  @attribute 'dateDisplayFormat', default: 'YYYY-MM-DD'

  @attribute 'timeValueFormat', default: 'HH:mm'

  @attribute 'timeDisplayFormat', default: 'HH:mm'

  @get 'value', ->
    @field.val()

  @set 'value', (val) ->
    @field.val val
    @_initMoment()

  _connected: ->
    @field = @jq.find '> input'
    @datePicker = @findComponent 'tao-date-picker'
    @timePicker = @findComponent 'tao-time-picker'
    @_bind()

  _disconnected: ->
    @off()

  _bind: ->
    @on 'tao-date-picker:change tao-time-picker:change', '.tao-moment-picker', (e, m) =>
      @_syncMoment()
      @namespacedTrigger 'change', [@moment]

    datePickerDeferred = $.Deferred()
    timePickerDeferred = $.Deferred()

    @on 'tao-date-picker:ready', 'tao-date-picker', ->
      datePickerDeferred.resolve()

    @on 'tao-time-picker:ready', 'tao-time-picker', ->
      timePickerDeferred.resolve()

    $.when(datePickerDeferred, timePickerDeferred).done =>
      @_initMoment()
      @namespacedTrigger 'ready'

  _initMoment: ->
    m = moment @field.val(), @valueFormat

    if m && m.isValid()
      @datePicker.setMoment m.format(@dateValueFormat)
      @timePicker.setMoment m.format(@timeValueFormat)
      @moment = m
    else
      @datePicker.setMoment ''
      @timePicker.setMoment ''
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

export default DateTimePickerElement.register()
