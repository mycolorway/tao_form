DataProvider = Tao.Form.Select.DataProvider

class Tao.Form.MultipleSelect.Element extends Tao.Form.Select.Element

  @tag 'tao-multiple-select'

  _connected: ->
    @field = @jq.find 'select'
    @selectedOption = []

    @dataProvider = new DataProvider
      remote: @remote
      field: @field

    @result = @findComponent '.select-result', =>
      values = @field.val()
      if values && _.isArray(values)
        @selectOption(value) for value in values

    @list = @findComponent '.select-list', =>
      @_initList()

    @_bindResultEvents()
    @_bindListEvents()

  _bindResultEvents: ->
    @on 'addClick', '.select-result', (e) =>
      @_toggleActive()
      null

    @on 'unselectOption', '.select-result', (e, option) =>
      _.remove @selectedOption, (opt) -> opt.value == option.value
      @active = false
      @_filterList ''
      @trigger 'change', @selectedOption
      null

    @on 'enterPress', '.select-result', (e) =>
      if @active
        if @selectOption @list.highlightedOption
          @trigger 'change', @selectedOption
      else
        @active = true
      null

    @on 'arrowPress', '.select-result', (e, direction) =>
      if @active
        if direction == 'up'
          @list.highlightPrevOption()
        else
          @list.highlightNextOption()
      else
        @active = true
      null

  _bindDocumentMousedown: ->
    $(document).on "mousedown.tao-select-#{@taoId}", (e) =>
      return if $.contains(@, e.target) && @result != e.target
      @active = false
      @_unbindDocumentMousedown()

  selectOption: (option) ->
    option = @dataProvider.getOption option
    return false unless option && !(option in @selectedOption)
    @result.selectOption option
    @selectedOption.push option
    @active = false
    true

  unselectOption: (option) ->
    option = @dataProvider.getOption option
    return false unless option && (option in @selectedOption)
    @result.unselectOption option
    _.remove @selectedOption, (opt) -> opt.value == option.value
    @active = false
    true

TaoComponent.register Tao.Form.MultipleSelect.Element
