
Tao.Form.Mixins.Checkable = ->

  @get 'checked', ->
    @field?.prop 'checked'

  @set 'checked', (value) ->
    @field?.prop 'checked', value

  _toggleChecked: ->
    @checked = !@checked
