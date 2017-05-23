class Tao.Form.Checkbox extends TaoComponent

  @tag 'tao-checkbox'

  @get 'checked', ->
    @field?.prop 'checked'

  @set 'checked', (value) ->
    @field?.prop 'checked', value

  _connected: ->
    @field = @jq.find('input:checkbox')
    @_bind()

  _bind: ->
    @on 'click', '.checkbox-wrapper', (e) =>
      if @field.is(':enabled')
        @_toggleChecked()
        @trigger 'change'
      false

    @on 'keydown', '.checkbox-wrapper', (e) =>
      return unless e.which == 13 && @field.is(':enabled')
      @_toggleChecked()
      @trigger 'change'
      false

  _disconnected: ->
    @off()

  _toggleChecked: ->
    @checked = !@checked

TaoComponent.register Tao.Form.Checkbox
