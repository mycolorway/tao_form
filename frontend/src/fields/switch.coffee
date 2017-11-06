import SwitchBaseElement from '../shared/fields/switch'

class SwitchElement extends SwitchBaseElement

  _bind: ->
    super()

    @on 'keydown', '.switch-wrapper', (e) =>
      return unless e.which == 13 && @field.is(':enabled')
      @_toggleChecked()
      @namespacedTrigger 'change'
      false

export default SwitchElement.register()
