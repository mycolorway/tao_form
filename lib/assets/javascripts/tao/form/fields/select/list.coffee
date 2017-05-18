
Option = Tao.Form.Select.Option

class Tao.Form.Select.List extends TaoComponent

  @tag 'tao-select-list'

  @attribute 'active', 'empty', 'loading', 'searchable', type: 'boolean'

  @attribute 'maxListSize', type: 'number'

  _connected: ->
    @searchField = @jq.find('.search-field')
    @highlightedOption = null

    @_bind()

  _disconnected: ->
    @off ".tao-select-list-#{@taoId}"

  _bind: ->
    @on "input.tao-select-list-#{@taoId}", '.search-field', _.debounce (e) =>
      @trigger 'search', [@searchField.val()]
    , 200

    @on "keydown.tao-select-list-#{@taoId}", '.search-field', (e) =>
      if e.which == 13
        @trigger('select', [@highlightedOption]) if @highlightedOption
        false
      else if e.which == 27
        @trigger 'searchEscapePress'
        false
      else if e.which == 38
        @highlightPrevOption()
        false
      else if e.which == 40
        @highlightNextOption()
      null

    @on "click.tao-select-list-#{@taoId}", '.option', (e) =>
      $option = $ e.currentTarget
      option = $option.data('option')
      @trigger('select', [option]) if option
      null

  _activeChanged: ->
    if @active
      @trigger 'show'
      @searchField.focus() if @searchable
    else
      @trigger 'hide'

  setOptions: (options, totalSize) ->
    @options = options.slice 0, @maxListSize
    $list = @jq.find('.options-list').empty()
    $tips = @jq.find('.tips')

    if @options.length > 0
      @empty = false

      @_lastRenderGroup = null
      for option in @options
        if option.group && @_lastRenderGroup != option.group
          $list.append @_renderGroup(option.group)
        $list.append @_renderOption(option)
    else
      @empty = true

    @_refreshTips totalSize

  _renderGroup: (name) ->
    $('<div>', class: 'optgroup').text(name)

  _renderOption: (option) ->
    $option = $("""
      <div class="option">
        <span class="name"></span>
        <span class="hint"></span>
      </div>
    """).data('option', option)
    $option.find('.name').text(option.data.label || option.name)
    $option.find('.hint').text(option.data.hint) if option.data.hint
    $option.attr 'data-value', option.value
    $option

  _refreshTips: (totalSize) ->
    if totalSize && @options.length > 0 && totalSize > @options.length
      $tips.removeClass('hidden')
        .find('.size').text(totalSize - @options.length)
    else
      $tips.addClass('hidden')
        .find('.size').text('')

  highlightNextOption: ->
    if @highlightedOption
      $option = @jq.find(".option[value='#{@highlightedOption.value}']").next('.option')
      @highlightOption $option
    else
      @highlightFirstOption()

  highlightPrevOption: ->
    if @highlightedOption
      $option = @jq.find(".option[value='#{@highlightedOption.value}']").prev('.option')
      @highlightOption $option
    else
      @highlightFirstOption()

  highlightFirstOption: ->
    @highlightOption @jq.find('.option:first')

  highlightOption: (option) ->
    if option instanceOf Option
      $option = @jq.find(".option[value='#{option.value}']")
    else
      $option = option

    return false unless $option && $option.length > 0
    $option.addClass('highlighted')
      .siblings('.option').removeClass('highlighted')



TaoComponent.register Tao.Form.Select.List
