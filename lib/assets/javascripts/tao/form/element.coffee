#= require ./base

class Tao.Form.Element extends Tao.Form.Base

  _bind: ->
    super

    @on 'focus', '.input-field', (e) =>
      $field = $ e.currentTarget
      $field.closest('.form-input').addClass 'focus'

    @on 'blur', '.input-field', (e) =>
      $field = $ e.currentTarget
      $field.closest('.form-input').removeClass 'focus'

TaoComponent.register Tao.Form.Element
window.TaoForm = Tao.Form.Element
