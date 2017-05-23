class Tao.Form.Radio extends TaoComponent

  @tag 'tao-radio'

  @get 'checked', ->
    @field?.prop 'checked'

  @set 'checked', (value) ->
    @field?.prop 'checked', value

  _connected: ->
    @field = @jq.find('input:radio')
    @_bind()

  _bind: ->
    @on 'click', '.radio-wrapper', (e) =>
      if @field.is(':enabled')
        @_toggleChecked()
        @trigger 'change'
      false

    @on 'keydown', '.radio-wrapper', (e) =>
      return unless e.which == 13 && @field.is(':enabled')
      @_toggleChecked()
      @trigger 'change'
      false

  _disconnected: ->
    @off()

  _toggleChecked: ->
    @checked = !@checked

TaoComponent.register Tao.Form.Radio
