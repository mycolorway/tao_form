import CheckboxBaseElement from '../shared/fields/checkbox'

class CheckboxElement extends CheckboxBaseElement

  _bind: ->
    super()

    @on 'keydown', '.checkbox-wrapper', (e) =>
      return unless e.which == 13 && @field.is(':enabled')
      @_toggleChecked()
      @namespacedTrigger 'change'

      false

export default CheckboxElement.register()
