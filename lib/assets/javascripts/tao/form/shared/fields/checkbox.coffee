#= require tao/form/shared/mixins/checkable

class Tao.Form.CheckboxBase extends TaoComponent

  @include Tao.Form.Mixins.Checkable

  @tag 'tao-check-box'

  @get 'indeterminate', ->
    @field?.prop 'indeterminate'

  @set 'indeterminate', (value) ->
    @field?.prop 'indeterminate', value

  _connected: ->
    @field = @jq.find('input:checkbox')
    @_bind()

  _bind: ->
    @on 'click', '.checkbox-wrapper', (e) =>
      if @field.is(':enabled')
        @_toggleChecked()
        @trigger 'tao-check-box:change'
      false

  _disconnected: ->
    @off()
