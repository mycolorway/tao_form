class Tao.Radio extends TaoComponent

  @tag 'tao-radio'

  @get 'checked', ->
    @field?.prop 'checked'

  @set 'checked', (value) ->
    @field?.prop 'checked', value

  _connected: ->
    @field = @jq.find('input:radio')
    @_bind()

  _bind: ->
    @on "click.tao-radio-#{@taoId}", '.radio-wrapper', (e) =>
      @_toggleChecked()
      @trigger 'change'
      false

    @on "keydown.tao-radio-#{@taoId}", '.radio-wrapper', (e) =>
      return unless e.which == 13
      @_toggleChecked()
      @trigger 'change'
      false

  _disconnected: ->
    @off ".tao-radio-#{@taoId}"

  _toggleChecked: ->
    @checked = !@checked

TaoComponent.register Tao.Radio
