import { Component } from '@mycolorway/tao'
import Checkable from '../mixins/checkable'

class RadioElementBase extends Component

  @include Checkable

  @tag 'tao-radio-button'

  _connected: ->
    @field = @jq.find('input:radio')
    @_bind()

  _bind: ->
    @on 'change', 'input[type=radio]', (e) =>
      @namespacedTrigger 'change'
      null

    @on 'click', '.radio-wrapper', (e) =>
      if @field.is(':enabled')
        @_toggleChecked()
        @namespacedTrigger 'change'
      false

  _disconnected: ->
    @off()

export default RadioElementBase
