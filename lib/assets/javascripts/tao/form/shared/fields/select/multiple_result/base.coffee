
class Tao.Form.Select.MultipleResultBase extends TaoComponent

  @tag 'tao-multiple-select-result'

  @attribute 'selected', type: 'boolean'

  @attribute 'disabled', type: 'boolean', observe: true

  _connected: ->
    @field = @jq.find 'select'
    @selectedOption = []
    @_bind()

  _disconnected: ->
    @off()

  _bind: ->
    @on 'click', 'select', =>
      @trigger 'tao:activeClick'
      false

    @on 'click', '.selected-item', (e) =>
      return if @disabled
      $option = $ e.currentTarget
      option = $option.data 'option'
      @unselectOption option
      @trigger 'tao:unselect', [option]
      false

  selectOption: (option) ->
    return false unless option && !(option in @selectedOption)

    unless @jq.find(".selected-item[data-value='#{option.value}']").length > 0
      $item = @_generateItem(option)
      if @selectedOption.length > 0
        @jq.find('.selected-item:last').after $item
      else
        @jq.prepend $item

    @selectedOption.push option
    @_setSelectedOption option
    @selected = true
    true

  unselectOption: (option) ->
    return false unless option && option in @selectedOption
    @jq.find(".selected-item[data-value='#{option.value}']").remove()
    _.remove @selectedOption, (opt) -> opt.value == option.value
    @_setUnselectedOption option
    @selected = false if @selectedOption.length == 0
    true

  _setSelectedOption: (option) ->
    return unless option
    $option = @field.find("option[value='#{option.value}']")
    $option = @_generateOption(option) unless $option.length > 0
    $option.prop 'selected', true

  _setUnselectedOption: (option) ->
    return unless option
    $option = @field.find("option[value='#{option.value}']")
    $option.prop 'selected', false

  _generateOption: (option) ->
    $option = $('<option>', test: option.text, value: option.value).appendTo(@field)
    @field.trigger 'tao:addOption', option, $option
    $option

  _generateItem: (option) ->
    $item = $("""
      <a href="javascript:;" class="selected-item" tabindex="-1">
        <span class="name"></span>
      </a>
    """)

    $item.append Tao.iconTag('close')
    $item.attr 'data-value', option.value
      .data 'option', option
      .find('.name').text option.text
    $item
