import FormElementBase from './shared/element/base'

class FormElement extends FormElementBase

  _bind: ->
    super()

    @on 'focus', '.input-field', (e) =>
      $field = $ e.currentTarget
      $field.closest('.form-input').addClass 'focus'

    @on 'blur', '.input-field', (e) =>
      $field = $ e.currentTarget
      $field.closest('.form-input').removeClass 'focus'

export default FormElement.register()
