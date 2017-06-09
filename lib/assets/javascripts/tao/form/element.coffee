#= require tao/form/shared/element/base

class Tao.Form.Element extends Tao.Form.ElementBase

  _bind: ->
    super

    @on 'focus', '.input-field', (e) =>
      $field = $ e.currentTarget
      $field.closest('.form-input').addClass 'focus'

    @on 'blur', '.input-field', (e) =>
      $field = $ e.currentTarget
      $field.closest('.form-input').removeClass 'focus'

TaoComponent.register Tao.Form.Element
