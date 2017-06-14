class Tao.Form.ElementBase extends TaoComponent

  @tag 'tao-form'

  @attribute 'successMessage'

  _connected: ->
    @_bind()

  _bind: ->
    @on 'ajax:beforeSend', '> form', (e) =>
      @_clearErrors()
      @trigger 'tao:beforeSubmit'

    @on 'ajax:success', '> form', (e) =>
      @_showSuccessMessage()
      @trigger 'tao:success'

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
      .append([Tao.iconTag('success'), @successMessage])
      .insertAfter $button.hide()

    @_successTimer = setTimeout =>
      $button.show()
      $message.remove()
    , 3000

  beforeCache: ->
    super
    clearTimeout @_successTimer
    @jq.find('.success-message').remove()
    @jq.find('button[data-disable-with]:hidden, input[data-disable-with]:hidden').show()
