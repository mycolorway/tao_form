#= require tao/form/shared/fields/switch

class Tao.Form.Switch extends Tao.Form.SwitchBase

  _bind: ->
    super

    @on 'keydown', '.switch-wrapper', (e) =>
      return unless e.which == 13 && @field.is(':enabled')
      @_toggleChecked()
      @namespacedTrigger 'change'
      false

TaoComponent.register Tao.Form.Switch
