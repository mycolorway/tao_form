import { Component } from '@mycolorway/tao'
import $ from 'jquery'
import _ from 'lodash'
import moment from 'moment'

class DateRangePickerElement extends Component

  @tag 'tao-date-range-picker'

  @attribute 'prefix'
  @attribute 'suffix'
  @attribute 'separator', default: ','

  @attribute 'dateValueFormat', default: 'YYYY-MM-DD'

  @attribute 'dateDisplayFormat', default: 'YYYY-MM-DD'

  @get 'value', ->
    @field?.val()

  @set 'value', (val) ->
    @field.val val
    @_initMoment()

  _connected: ->
    @field = @jq.find '> input'
    @startDatePicker = @findComponent '.start-date-picker'
    @endDatePicker = @findComponent '.end-date-picker'
    @_bind()

  _disconnected: ->
    @off()

  _bind: ->
    @on 'tao-date-picker:change', '.tao-moment-picker', (e, m) =>
      datePicker = e.currentTarget
      if datePicker == @startDatePicker
        @endDatePicker.disableBefore datePicker.moment
      else
        @startDatePicker.disableAfter datePicker.moment
      @_syncMoment()
      @namespacedTrigger('change', [@value])

    startDatePickerDeferred = $.Deferred()
    endDatePickerDeferred = $.Deferred()

    @on 'tao-date-picker:ready', '.start-date-picker', ->
      startDatePickerDeferred.resolve()

    @on 'tao-date-picker:ready', '.end-date-picker', ->
      endDatePickerDeferred.resolve()

    $.when(startDatePickerDeferred, endDatePickerDeferred).done =>
      @_initMoment()
      @namespacedTrigger 'ready'

  _parseValue: ->
    prefix = if @prefix then "\\#{@prefix}" else ''
    suffix = if @suffix then "\\#{@suffix}" else ''
    separator = if @separator then "\\#{@separator}" else ''

    regexp = new RegExp "^#{prefix}(.*)#{separator}(.*)#{suffix}$"
    if matches = @field.val().match(regexp)
      [matches[1], matches[2]]
    else
      []

  _initMoment: ->
    dates = @_parseValue()
    @startDate = moment _.trim(dates[0]), @dateValueFormat
    @endDate = moment _.trim(dates[1]), @dateValueFormat

    if @startDate.isValid()
      @startDatePicker.setMoment @startDate.clone()
      @endDatePicker.disableBefore @startDate.clone()
    else
      @startDatePicker.setMoment ''
      @startDate = null

    if @endDate.isValid()
      @endDatePicker.setMoment @endDate.clone()
      @startDatePicker.disableAfter @endDate.clone()
    else
      @endDatePicker.setMoment ''
      @endDate = null

  _syncMoment: ->
    startDateValue = @startDatePicker.moment?.format(@dateValueFormat)
    endDateValue = @endDatePicker.moment?.format(@dateValueFormat)

    if startDateValue || endDateValue
      @field.val ["#{@prefix}#{startDateValue || ''}", "#{endDateValue || ''}#{@suffix}"].join(@separator)
    else
      @field.val ''

    @startDate = @startDatePicker.moment?.clone()
    @endDate = @endDatePicker.moment?.clone()


export default DateRangePickerElement.register()
