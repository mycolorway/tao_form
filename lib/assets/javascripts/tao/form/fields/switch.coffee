class Tao.Form.Switch extends TaoComponent

  @tag 'tao-switch'

  @get 'checked', ->
    @field?.prop 'checked'

  @set 'checked', (value) ->
    @field?.prop 'checked', value

  _connected: ->
    @field = @jq.find('input:checkbox')
    @_bind()

  _bind: ->
    @on 'click', '.switch-wrapper', (e) =>
      if @field.is(':enabled')
        @_toggleChecked()
        @trigger 'change'
      false

    @on 'keydown', '.switch-wrapper', (e) =>
      return unless e.which == 13 && @field.is(':enabled')
      @_toggleChecked()
      @trigger 'change'
      false

  _disconnected: ->
    @off()

  _toggleChecked: ->
    @checked = !@checked

TaoComponent.register Tao.Form.Switch
