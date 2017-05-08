class Tao.Form.Base extends TaoComponent

  @tag 'tao-form'

  @attribute 'successMessage'

  _connected: ->
    @form = @jq.find '> form'
    @_bind()

  _bind: ->
    @form.on "ajax:beforeSend.tao-form-#{@taoId}", (e) =>
      @_clearErrors()
      @trigger 'beforeSubmit'

    @form.on "ajax:success.tao-form-#{@taoId}", (e) =>
      @_showSuccessMessage()
      @trigger 'success'

  _disconnected: ->
    @form.off ".tao-form-#{@taoId}"
    @form = null

  _clearErrors: ->
    @form.find('.input-with-errors').each (i, input) =>
      @_clearError input

  _clearError: (input) ->
    $(input).removeClass('input-with-errors')
      .find('.error').remove()

  _showSuccessMessage: ->
    return unless @successMessage

    $button = @form.find('button[data-disable-with]:disabled, input[data-disable-with]:disabled')
    $message = $('<div>')
      .addClass('success-message')
      .append([Tao.ui.iconTag('success'), @successMessage])
      .insertAfter $button.hide()

    @_successTimer = setTimeout =>
      $button.show()
      $message.remove()
    , 3000

  beforeCache: ->
    super
    clearTimeout @_successTimer
    @form.find('.success-message').remove()
    @form.find('button[data-disable-with]:hidden, input[data-disable-with]:hidden').show()
