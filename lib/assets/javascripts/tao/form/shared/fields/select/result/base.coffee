
class Tao.Form.Select.ResultBase extends TaoComponent

  @tag 'tao-select-result'

  @attribute 'selected', 'clearable', type: 'boolean'

  @attribute 'disabled', type: 'boolean', observe: true

  _connected: ->
    @field = @jq.find 'select'
    @_bind()

  _disconnected: ->
    @off()

  _bind: ->
    @on 'click', 'select', =>
      @trigger 'tao:activeClick'
      false

    @on 'click', '.link-clear', (e) =>
      return if @disabled
      @clearSelected() && @trigger('tao:clear')
      false

  selectOption: (option) ->
    return false unless option
    @selectedOption = option
    @selected = true
    @_setSelectedOption option
    @jq.find('.selected-text').text option.text
    true

  unselectOption: (option = @selectedOption) ->
    return false unless option
    @selectedOption = null
    @selected = false
    @_setSelectedOption false
    @jq.find('.selected-text').text ''
    true

  clearSelected: ->
    @unselectOption()

  _setSelectedOption: (option) ->
    @field.find('option:selected').prop 'selected', false
    return unless option

    $option = @field.find("option[value='#{option.value}']")
    $option = @_generateOption(option) unless $option.length > 0
    $option.prop 'selected', true

  _generateOption: (option) ->
    $option = $('<option>', test: option.text, value: option.value).appendTo(@field)
    @field.trigger 'tao:addOption', option, $option
    $option
