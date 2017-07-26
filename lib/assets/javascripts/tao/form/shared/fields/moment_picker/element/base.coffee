class Tao.Form.MomentPicker.ElementBase extends TaoComponent

  @attribute 'valueFormat', 'displayFormat'

  @attribute 'active', 'disabled', type: 'boolean', observe: true

  @get 'value', ->
    @field?.val()

  @set 'value', (val) ->
    @setMoment val

  _connected: ->
    [@result, @segmentList] = @findComponent(
      '.tao-moment-picker-result',
      '.tao-moment-picker-segment-list',
      @_childComponentsReady.bind(@)
    )
    @_bind()

  _disconnected: ->
    @off()

  _bind: ->
    @on 'tao:activeClick', '.tao-moment-picker-result', (e) =>
      return if @disabled
      @_toggleActive()
      null

    @on 'tao:clear', '.tao-moment-picker-result', (e) =>
      return if @disabled
      @active = false
      @setMoment null
      @trigger 'tao:change', [@moment]
      null

    @on 'tao:select', '.tao-moment-picker-segment-list', (e, m) =>
      @active = false
      @setMoment m
      @trigger 'tao:change', [@moment]
      null

  _childComponentsReady: ->
    @field = @result.field
    @result.format = @displayFormat
    @setMoment @field.val()
    @trigger 'tao:ready'

  _toggleActive: ->
    @active = !@active

  setMoment: (m) ->
    m = moment(m, @valueFormat) unless moment.isMoment(m)
    if m && m.isValid()
      @result.setMoment m
      @field.val m.format(@valueFormat)
      @moment = m
    else
      @result.setMoment null
      @field.val ''
      @moment = null
    @moment

  disableBefore: (m) ->
    @segmentList.segments.forEach (segment) ->
      segment.disableBefore = m

  disableAfter: (m) ->
    @segmentList.segments.forEach (segment) ->
      segment.disableAfter = m
