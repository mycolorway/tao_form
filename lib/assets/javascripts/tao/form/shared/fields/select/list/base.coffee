#= require tao/form/shared/fields/select/models/option

Option = Tao.Form.Select.Option

class Tao.Form.Select.ListBase extends TaoComponent

  @tag 'tao-select-list'

  @attribute 'empty', 'loading', 'searching', 'searchable', type: 'boolean'

  @attribute 'hiddenSize', type: 'number', observe: true

  @attribute 'maxListSize', type: 'number', default: 20

  _connected: ->
    @searchField = @jq.find('.search-field')
    @_bind()

  _disconnected: ->
    @off()

  _bind: ->
    @on 'input', '.search-field', _.debounce (e) =>
      val = @searchField.val()
      @searching = !!val
      @trigger 'search', [val]
    , 200

    @on 'click', '.option', (e) =>
      $option = $ e.currentTarget
      option = $option.data('option')
      @trigger('selectOption', [option]) if option
      null

  _hiddenSizeChanged: ->
    @jq.find('.tips .size').text(@hiddenSize)

  _refreshScrollPosition: ->
    @reflow()
    @jq.find('.list-wrapper').scrollTop 0

  setOptions: (options, totalSize) ->
    @options = options.slice 0, @maxListSize
    @hiddenSize = (totalSize || @options.length) - @options.length
    $list = @jq.find('.options-list').empty()

    if @options.length > 0
      @empty = false

      @_lastRenderGroup = null
      for option in @options
        if option.data.group && @_lastRenderGroup != option.data.group
          @_lastRenderGroup = option.data.group
          $list.append @_renderGroup(option.data.group)
        $list.append @_renderOption(option)

      @_refreshScrollPosition()
    else
      @empty = true

  _renderGroup: (name) ->
    $('<div>', class: 'optgroup').text(name)

  _renderOption: (option) ->
    $option = $("""
      <div class="option">
        <span class="name"></span>
        <span class="hint"></span>
      </div>
    """).data('option', option)
    $option.find('.name').text(option.data.label || option.text)
    $option.find('.hint').text(option.data.hint) if option.data.hint
    $option.attr 'data-value', option.value
    $option

  reset: ->
    @searchField.val ''
    @searching = false
    @trigger 'search', ['']
