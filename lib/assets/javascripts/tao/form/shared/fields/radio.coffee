class Tao.Form.RadioBase extends TaoComponent

  @include Tao.Form.Mixins.Checkable

  @tag 'tao-radio-button'

  _connected: ->
    @field = @jq.find('input:radio')
    @_bind()

  _bind: ->
    @on 'click', '.radio-wrapper', (e) =>
      if @field.is(':enabled')
        @_toggleChecked()
        @trigger 'tao:change'
      false

  _disconnected: ->
    @off()
