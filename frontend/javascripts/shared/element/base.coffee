import { Component } from '@mycolorway/tao'
import createIcon from '@mycolorway/tao_ui/frontend/javascripts/icons/create'
import $ from 'jquery'

class FormElementBase extends Component

  @tag 'tao-form'

  @attribute 'successMessage'

  _connected: ->
    @form = @jq.find('> form')
    @_bind()
    @jq.find('.input-field[autofocus]').focus()

  _bind: ->
    @on 'ajax:beforeSend', '> form', (e) =>
      return unless @form.is(e.target)
      @_clearErrors()
      @namespacedTrigger 'beforeSubmit'

    @on 'ajax:success', '> form', (e) =>
      return unless @form.is(e.target)
      @_showSuccessMessage()
      @namespacedTrigger 'success'

  _disconnected: ->
    @off()

  _clearErrors: ->
    @jq.find('.input-with-errors').each (i, input) =>
      @_clearError input

  _clearError: (input) ->
    $(input).removeClass('input-with-errors')
      .find('.error').remove()

  _showSuccessMessage: ->
    return unless @successMessage

    $button = @jq.find('button[data-disable-with]:disabled, input[data-disable-with]:disabled')
    $message = $('<div>')
      .addClass('success-message')
      .append([createIcon('success'), @successMessage])
      .insertAfter $button.hide()

    @_successTimer = setTimeout =>
      $button.show()
      $message.remove()
    , 3000

  beforeCache: ->
    super()
    clearTimeout @_successTimer
    @jq.find('.success-message').remove()
    @jq.find('button[data-disable-with]:hidden, input[data-disable-with]:hidden').show()

  submit: ->
    @form.submit()
    @

export default FormElementBase
