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
    @selectedOption ||= if @multiple then [] else null

    @dataProvider = new DataProvider
      remote: @remote
      field: @field

    [@result, @list] = @findComponent '.select-result', '.select-list', =>
      @_childComponentsReady()
      @namespacedTrigger 'ready'

    @_bind()

  _childComponentsReady: ->
    if @multiple
      values = @field.val()
      if values && _.isArray(values)
        @selectOption(value) for value in values
    else
      @selectOption @field.val()

    @list.setOptions @dataProvider.options, @remote?.totalOptionSize
    @list.searchable = if @remote
      @dataProvider.options.length < @remote.totalOptionSize
    else
      @dataProvider.options.length > @searchableSize

  _bind: ->
    @_bindResultEvents()
    @_bindListEvents()

  _bindResultEvents: ->
    @on 'tao:activeClick', '.select-result', (e) =>
      @_toggleActive()
      null

    if @multiple
      @on 'tao:unselect', '.select-result', (e, option) =>
        @unselectOption option
        @_filterList ''
        @namespacedTrigger 'change', @selectedOption
        null
    else
      @on 'tao:clear', '.select-result', (e) =>
        @active = false
        @clearSelected()
        @_filterList ''
        @namespacedTrigger 'change', @selectedOption
        null

  _bindListEvents: ->
    @on 'tao:select', '.select-list', (e, option) =>
      @selectOption option
      @namespacedTrigger 'change', @selectedOption
      null

    @on 'tao:search', '.select-list', (e, value) =>
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
      @list.setOptions options, totalSize

  selectOption: (option) ->
    option = @dataProvider.getOption option
    return false unless option && option != @selectedOption
    @result.selectOption option
    @list.clearSelected() unless @multiple
    @list.selectOption option
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
      @list.unselectOption option
      _.remove @selectedOption, (opt) -> opt.value == option.value
      @selected = false if @selectedOption.length == 0
    else
      @clearSelected()
    true

  clearSelected: ->
    @result.clearSelected()
    @list.clearSelected()
    @selected = false
    if @multiple
      @selectedOption.length = 0
    else
      @selectedOption = null
    true

  refreshOptions: ->
    @active = false
    @dataProvider.reset()
    @_filterList ''
    @
