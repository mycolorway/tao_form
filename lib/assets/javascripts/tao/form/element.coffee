#= require ./base

class Tao.Form.Element extends Tao.Form.Base

  _bind: ->
    super

    @form.on "focus.tao-form-#{@taoId}", '.input-field', (e) =>
      $field = $ e.currentTarget
      $field.closest('.form-input').addClass 'focus'

    @form.on "blur.tao-form-#{@taoId}", '.input-field', (e) =>
      $field = $ e.currentTarget
      $field.closest('.form-input').removeClass 'focus'

TaoComponent.register Tao.Form.Element
window.TaoForm = Tao.Form.Element
