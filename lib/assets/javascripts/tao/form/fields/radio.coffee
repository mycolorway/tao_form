#= require tao/form/shared/fields/radio

class Tao.Form.Radio extends Tao.Form.RadioBase

  _bind: ->
    super

    @on 'keydown', '.radio-wrapper', (e) =>
      return unless e.which == 13 && @field.is(':enabled')
      @_toggleChecked()
      @trigger 'tao:change'
      false

TaoComponent.register Tao.Form.Radio
