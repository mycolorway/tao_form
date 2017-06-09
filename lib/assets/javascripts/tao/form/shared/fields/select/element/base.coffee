#= require tao/form/shared/fields/select/models/data_provider

DataProvider = Tao.Form.Select.DataProvider

class Tao.Form.Select.ElementBase extends TaoComponent

  @tag 'tao-select'

  @attribute 'multiple', type: 'boolean'

  @attribute 'active', 'selected', type: 'boolean', observe: true

  @attribute 'remote', type: 'hash'

  @attribute 'searchableSize', type: 'number', default: 8

  @get 'value', ->
    @field.val()

  _connected: ->
    @field = @jq.find 'select'
    @selectedOption = if @multiple then [] else null

    @dataProvider = new DataProvider
      remote: @remote
      field: @field

    @result = @findComponent '.select-result', =>
      @_resultReady()

    @list = @findComponent '.select-list', =>
      @_listReady()

    @_bind()

  _resultReady: ->
    if @multiple
      values = @field.val()
      if values && _.isArray(values)
        @selectOption(value) for value in values
    else
      @selectOption @field.val()

  _listReady: ->
    options = @dataProvider.unselectedOptions()
    @list.setOptions options, @remote?.totalOptionSize
    @list.searchable = if @remote
      @dataProvider.options.length < @remote.totalOptionSize
    else
      @dataProvider.options.length > @searchableSize

  _bind: ->
    @_bindResultEvents()
    @_bindListEvents()

  _bindResultEvents: ->
    @on 'activeClick', '.select-result', (e) =>
      @_toggleActive()
      null

    if @multiple
      @on 'unselectOption', '.select-result', (e, option) =>
        _.remove @selectedOption, (opt) -> opt.value == option.value
        @selected = false if @selectedOption.length == 0
        @_filterList ''
        @trigger 'change', @selectedOption
        null
    else
      @on 'clear', '.select-result', (e) =>
        @active = false
        @selectedOption = null
        @selected = false
        @_filterList ''
        @trigger 'change', @selectedOption
        null

  _bindListEvents: ->
    @on 'selectOption', '.select-list', (e, option) =>
      @selectOption option
      @trigger 'change', @selectedOption
      null

    @on 'search', '.select-list', (e, value) =>
      @_filterList value

  _disconnected: ->
    @off()
    @dataProvider = null

  _toggleActive: ->
    @active = !@active

  _filterList: (value) ->
    @list.loading = true
    @dataProvider.filter value, (options, totalSize) =>
      @list.loading = false
      options = @dataProvider.unselectedOptions options
      @list.setOptions options, totalSize

  selectOption: (option) ->
    option = @dataProvider.getOption option
    return false unless option && option != @selectedOption
    @result.selectOption option
    if @multiple
      @selectedOption.push option
    else
      @selectedOption = option
    @selected = true
    true

  unselectOption: (option) ->
    if @multiple
      option = @dataProvider.getOption option
      return false unless option && (option in @selectedOption)
      @result.unselectOption option
      _.remove @selectedOption, (opt) -> opt.value == option.value
      @selected = false if @selectedOption.length == 0
    else
      @result.unselectOption()
      @selectedOption = null
      @selected = false
    true
