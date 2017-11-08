import { Component } from '@mycolorway/tao'
import Checkable from '../mixins/checkable'

class SwitchElementBase extends Component

  @include Checkable

  @tag 'tao-switch'

  _connected: ->
    @field = @jq.find('input:checkbox')
    @_bind()

  _bind: ->
    @on 'change', 'input[type=checkbox]', (e) =>
      @namespacedTrigger 'change'
      null

    @on 'click', '.switch-wrapper', (e) =>
      if @field.is(':enabled')
        @_toggleChecked()
        @namespacedTrigger 'change'
      false

  _disconnected: ->
    @off()

export default SwitchElementBase
