class Tao.Form.Select.Element extends TaoComponent

  @tag 'tao-select'

  @attribute 'active', type: 'boolean'

  @attribute 'remote', type: 'hash'

  @attribute 'maxListSize', type: 'number', default: 20

  @attribute 'listOffset', type: 'number', default: 6

  @attribute 'searchableSize', type: 'number', default: 8

  @get 'value', ->
    @field.val()

  _connected: ->
    @field = @jq.find 'select'
    @result = @jq.find('.select-result').get(0)
    @list = @jq.find('.select-list').get(0)
    @selectedOption = null

    @dataProvider = new DataProvider
      remote: @remote
      field: @field

    if @list.connected
      @_initList()
    else
      @on "connected.tao-select-#{@taoId}", '.select-list', (e) =>
        @_initList()

    @selectOption @field.val()
    @_bind()

  _initList: ->
    options = @dataProvider.options.filter (option) -> option.value != @value
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
      @list.loading = true
      @dataProvider.filter value, (options, totalSize) =>
        options = options.filter (option) -> option.value != @value
        @list.setOptions options, totalSize
        @list.loading = false

  _disconnected: ->
    @off ".tao-select-#{@taoId}"
    $(document).off ".tao-select-#{@taoId}"
    @dataProvider = null

  _toggleActive: ->
    @active = !@active

  _activeChanged: ->
    @list.active = @active

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
    listHeight = @list.jq.outerHeight()

    if offsetToWindowBottom < listHeight
      @list.jq.css
        maxHeight: offsetToWindowTop - 20
        top: - listHeight - @listOffset
    else
      @list.jq.css
        maxHeight: offsetToWindowBottom - 20
        top: @result.jq.outerHeight() + @listOffset

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

TaoComponent.register Tao.Form.Select
