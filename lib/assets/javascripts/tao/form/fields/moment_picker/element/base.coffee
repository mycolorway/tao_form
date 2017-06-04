
class Tao.Form.MomentPicker.ElementBase extends TaoComponent

  @attribute 'valueFormat', 'displayFormat'

  @attribute 'active', 'disabled', type: 'boolean', observe: true

  _connected: ->
    @field = @jq.find 'input'
    @result = @findComponent 'tao-moment-picker-result', =>
      @result.format = @displayFormat
      @setMoment @field.val()
    @segmentList = @findComponent 'tao-moment-picker-segment-list'

    @_bind()

  _disconnected: ->
    @off()

  _bind: ->
    @on 'activeClick', 'tao-moment-picker-result', (e) =>
      return if @disabled
      @_toggleActive()
      null

    @on 'clear', 'tao-moment-picker-result', (e) =>
      return if @disabled
      @active = false
      @setMoment null
      null

    @on 'momentSelect', 'tao-moment-picker-segment-list', (e, m) =>
      @active = false
      @setMoment m
      null

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
