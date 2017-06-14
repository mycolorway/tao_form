#= require tao/form/shared/fields/checkbox

class Tao.Form.Checkbox extends Tao.Form.CheckboxBase

  _bind: ->
    super

    @on 'keydown', '.checkbox-wrapper', (e) =>
      return unless e.which == 13 && @field.is(':enabled')
      @_toggleChecked()
      @trigger 'tao:change'
      false

TaoComponent.register Tao.Form.Checkbox
