class Tao.Checkbox extends TaoComponent

  @tag 'tao-checkbox'

  @get 'checked', ->
    @field?.prop 'checked'

  @set 'checked', (value) ->
    @field?.prop 'checked', value

  _connected: ->
    @field = @jq.find('input:checkbox')
    @_bind()

  _bind: ->
    @on "click.tao-checkbox-#{@taoId}", '.checkbox-wrapper', (e) =>
      @_toggleChecked()
      @trigger 'change'
      false

    @on "keydown.tao-checkbox-#{@taoId}", '.checkbox-wrapper', (e) =>
      return unless e.which == 13
      @_toggleChecked()
      @trigger 'change'
      false

  _disconnected: ->
    @off ".tao-checkbox-#{@taoId}"

  _toggleChecked: ->
    @checked = !@checked

TaoComponent.register Tao.Checkbox
