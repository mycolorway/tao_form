import { Component } from '@mycolorway/tao'
import Checkable from '../mixins/checkable'

class CheckboxElementBase extends Component

  @include Checkable

  @tag 'tao-check-box'

  @get 'indeterminate', ->
    @field?.prop 'indeterminate'

  @set 'indeterminate', (value) ->
    @field?.prop 'indeterminate', value

  _connected: ->
    @field = @jq.find('input:checkbox')
    @_bind()

  _bind: ->
    @on 'change', 'input[type=checkbox]', (e) =>
      @namespacedTrigger 'change'
      null

    @on 'click', '.checkbox-wrapper', (e) =>
      if @field.is(':enabled')
        @_toggleChecked()
        @namespacedTrigger 'change'
      false

  _disconnected: ->
    @off()

export default CheckboxElementBase
