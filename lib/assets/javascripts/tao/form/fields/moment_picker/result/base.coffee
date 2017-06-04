
class Tao.Form.MomentPicker.ResultBase extends TaoComponent

  @tag 'tao-moment-picker-result'

  @attribute 'selected', type: 'boolean'

  @attribute 'disabled', type: 'boolean', observe: true

  @attribute 'format'

  _connected: ->
    @field = @jq.find 'input'
    @_bind()

  _disconnected: ->
    @off()

  _bind: ->
    @on 'click', 'input', =>
      @trigger 'activeClick'
      false

    @on 'click', '.link-clear', (e) =>
      return if @disabled
      @clear() && @trigger('clear')
      false

  clear: ->
    @moment = null
    @selected = false
    @jq.find('.result-text').text ''

  setMoment: (m) ->
    unless m && moment.isMoment(m)
      @clear()
      return
    @moment = m
    @selected = true
    @jq.find('.result-text').text m.format(@format)
