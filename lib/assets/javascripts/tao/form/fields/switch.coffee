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
    @on "click.tao-switch-#{@taoId}", '.switch-wrapper', (e) =>
      if @field.is(':enabled')
        @_toggleChecked()
        @trigger 'change'
      false

    @on "keydown.tao-switch-#{@taoId}", '.switch-wrapper', (e) =>
      return unless e.which == 13 && @field.is(':enabled')
      @_toggleChecked()
      @trigger 'change'
      false

  _disconnected: ->
    @off ".tao-switch-#{@taoId}"

  _toggleChecked: ->
    @checked = !@checked

TaoComponent.register Tao.Form.Switch
