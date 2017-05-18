
Option = Tao.Form.Select.Option

class Tao.Form.Select.Result extends TaoComponent

  @tag 'tao-select-result'

  @attribute 'selected', type: 'boolean',

  @attribute 'clearable', type: 'boolean'

  @attribute 'disabled', type: 'boolean'

  _connected: ->
    @field = @jq.find 'select'
    @_bind()

  _disconnected: ->
    @off ".tao-select-result-#{@taoId}"

  _bind: ->
    @on "click.tao-select-result-#{@taoId}", (e) =>
      return false if @disabled

    @on "click.tao-select-result-#{@taoId}", '.link-clear', (e) =>
      return if @disabled
      selectedOption = @selectedOption
      @clear()
      @trigger 'clear', [selectedOption]
      false

    @on "keydown.tao-select-result-#{@taoId}", (e) =>
      return if @disabled
      if e.which == 13
        @trigger 'enterPress'
        false
      else if e.which == 38
        @trigger 'arrowPress', ['up']
        false
      else if e.which == 40
        @trigger 'arrowPress', ['down']
        false

  _disabledChanged: ->
    if @disabled
      @jq.removeAttr 'tabindex'
    else
      @jq.attr 'tabindex', '0'

  selectOption: (option) ->
    return unless option
    @jq.find('.selected-text').text option.text
    @selected = true
    @selectedOption = option
    @_setSelectedOption option
    @

  unselectOption: (option = @selectedOption) ->
    return unless option
    @jq.find('.selected-text').text ''
    @selected = false
    @selectedOption = null
    @_setSelectedOption false
    @

  _setSelectedOption: (option) ->
    @field.find('option:selected').prop 'selected', false
    if option
      $option = @field.find("option[value='#{option.value}']")
      $option = @_generateOption(option) unless $option.length > 0
      $option.prop 'selected', true

  _generateOption: (option) ->
    $option = $('<option>', test: option.text, value: option.value).appendTo(@field)
    @field.trigger 'addOption', option, $option
    $option

  clear: ->
    @unselectOption()
    @


TaoComponent.register Tao.Form.Select.Result
