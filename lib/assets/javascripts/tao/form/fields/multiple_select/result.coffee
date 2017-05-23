
class Tao.Form.MultipleSelect.Result extends TaoComponent

  @tag 'tao-multiple-select-result'

  @attribute 'active', 'selected', 'clearable', type: 'boolean'

  @attribute 'disabled', type: 'boolean', observe: true

  _connected: ->
    @field = @jq.find 'select'
    @linkAdd = @jq.find '.link-add'
    @linkAdd.attr('tabindex', '0') unless @disabled
    @selectedOption = []
    @_bind()

  _disconnected: ->
    @off()

  _bind: ->
    @on 'click', '.link-add', (e) =>
      return if @disabled
      @trigger 'addClick'
      false

    @on 'click', '.selected-item', (e) =>
      return if @disabled
      $option = $ e.currentTarget
      option = $option.data 'option'
      @unselectOption option
      @trigger 'unselectOption', [option]
      false

    @on 'keydown', '.link-add', (e) =>
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
      @linkAdd.removeAttr 'tabindex'
    else
      @linkAdd.attr 'tabindex', '0'

  selectOption: (option) ->
    return false unless option && !(option in @selectedOption)
    @linkAdd.before @_generateItem(option)
    @selected = true
    @selectedOption.push option
    @_setSelectedOption option
    true

  unselectOption: (option) ->
    return false unless option && option in @selectedOption
    @jq.find(".selected-item[data-value='#{option.value}']").remove()
    @selected = false
    _.remove @selectedOption, (opt) -> opt.value == option.value
    @_setUnselectedOption option
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
    @field.trigger 'addOption', option, $option
    $option

  _generateItem: (option) ->
    $item = $("""
      <a href="javascript:;" class="selected-item" tabindex="-1">
        <span class="name"></span>
      </a>
    """)

    $item.append Tao.ui.iconTag('close')
    $item.attr 'data-value', option.value
      .data 'option', option
      .find('.name').text option.text
    $item

  focus: ->
    @linkAdd.focus()


TaoComponent.register Tao.Form.MultipleSelect.Result
