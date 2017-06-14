#= require tao/form/shared/mixins/checkable

class Tao.Form.CheckboxBase extends TaoComponent

  @include Tao.Form.Mixins.Checkable

  @tag 'tao-check-box'

  _connected: ->
    @field = @jq.find('input:checkbox')
    @_bind()

  _bind: ->
    @on 'click', '.checkbox-wrapper', (e) =>
      if @field.is(':enabled')
        @_toggleChecked()
        @trigger 'tao:change'
      false

  _disconnected: ->
    @off()
