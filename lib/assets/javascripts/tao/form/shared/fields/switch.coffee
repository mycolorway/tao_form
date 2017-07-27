class Tao.Form.SwitchBase extends TaoComponent

  @include Tao.Form.Mixins.Checkable

  @tag 'tao-switch'

  _connected: ->
    @field = @jq.find('input:checkbox')
    @_bind()

  _bind: ->
    @on 'click', '.switch-wrapper', (e) =>
      if @field.is(':enabled')
        @_toggleChecked()
        @namespacedTrigger 'change'
      false

  _disconnected: ->
    @off()
