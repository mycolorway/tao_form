DataProvider = Tao.Form.Select.DataProvider

class Tao.Form.Select.Element extends TaoComponent

  @tag 'tao-select'

  @attribute 'active', type: 'boolean', observe: true

  @attribute 'remote', type: 'hash'

  @attribute 'searchableSize', type: 'number', default: 8

  @get 'value', ->
    @field.val()

  _connected: ->
    @field = @jq.find 'select'
    @selectedOption = null

    @dataProvider = new DataProvider
      remote: @remote
      field: @field

    @result = @findComponent '.select-result', =>
      @selectOption @field.val()

    @list = @findComponent '.select-list', =>
      @_initList()

    @_bind()

  _initList: ->
    options = @dataProvider.options.filter (option) => option.value != @value
    @list.setOptions options, @remote?.totalOptionSize
    @list.searchable = if @remote
      @dataProvider.options.length < @remote.totalOptionSize
    else
      @dataProvider.options.length > @searchableSize

  _bind: ->
    @on "click.tao-select-#{@taoId}", '.select-result', (e) =>
      @_toggleActive()
      null

    @on "enterPress.tao-select-#{@taoId}", '.select-result', (e) =>
      if @active
        if @selectOption @list.highlightedOption
          @trigger 'change', @selectedOption
      else
        @active = true
      null

    @on "arrowPress.tao-select-#{@taoId}", '.select-result', (e, direction) =>
      if @active
        if direction == 'up'
          @list.highlightPrevOption()
        else
          @list.highlightNextOption()
      else
        @active = true
      null

    @on "clear.tao-select-#{@taoId}", '.select-result', (e) =>
      @active = false
      @_filterList ''
      null

    @on "select.tao-select-#{@taoId}", '.select-list', (e, option) =>
      @selectOption option
      @trigger 'change', @selectedOption
      null

    @on "show.tao-select-#{@taoId}", '.select-list', (e) =>
      @_positionList()

    @on "searchEscapePress.tao-select-#{@taoId}", '.select-list', (e) =>
      @active = false
      null

    @on "search.tao-select-#{@taoId}", (e, value) =>
      @_filterList value

  _disconnected: ->
    @off ".tao-select-#{@taoId}"
    $(document).off ".tao-select-#{@taoId}"
    @dataProvider = null

  _toggleActive: ->
    @active = !@active

  _activeChanged: ->
    @list.active = @active
    @result.active = @active

    @_unbindDocumentMousedown()
    if @active
      @_bindDocumentMousedown()
    else
      @result.jq.focus()
    @

  _unbindDocumentMousedown: ->
    $(document).off "mousedown.tao-select-#{@taoId}"

  _bindDocumentMousedown: ->
    $(document).on "mousedown.tao-select-#{@taoId}", (e) =>
      return if $.contains(@, e.target)
      @active = false
      @_unbindDocumentMousedown()

  _positionList: ->
    rect = @getBoundingClientRect()
    offsetToWindowTop = rect.top
    offsetToWindowBottom = $(window).height() - rect.bottom

    @list.setMaxHeight false
    @_reflow()
    listHeight = @list.jq.outerHeight()

    if offsetToWindowBottom < listHeight && offsetToWindowTop > offsetToWindowBottom
      @list.setMaxHeight offsetToWindowTop - 20
      @list.direction = 'up'
    else
      @list.setMaxHeight(offsetToWindowBottom - 20) if offsetToWindowBottom < listHeight
      @list.direction = 'down'

  _filterList: (value) ->
    @list.loading = true
    @dataProvider.filter value, (options, totalSize) =>
      @list.loading = false
      options = options.filter (option) => option.value != @value
      @list.setOptions options, totalSize

  selectOption: (option) ->
    option = @dataProvider.getOption option
    return false unless option && option != @selectedOption
    @result.selectOption option
    @selectedOption = option
    @active = false
    option

  unselectOption: ->
    @result.unselectOption()
    @selectedOption = null
    @active = false
    @

TaoComponent.register Tao.Form.Select.Element
