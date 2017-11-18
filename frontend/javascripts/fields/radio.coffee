import RadioBaseElement from '../shared/fields/radio'

class RadioElement extends RadioBaseElement

  _bind: ->
    super()

    @on 'keydown', '.radio-wrapper', (e) =>
      return unless e.which == 13 && @field.is(':enabled')
      @_toggleChecked()
      @namespacedTrigger 'change'
      false

export default RadioElement.register()
