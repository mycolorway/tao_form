
Option = Tao.Form.Select.Option

class Tao.Form.Select.List extends TaoComponent

  @tag 'tao-select-list'

  @attribute 'active', type: 'boolean', observe: true

  @attribute 'empty', 'loading', 'searchable', type: 'boolean'

  @attribute 'direction'

  @attribute 'maxListSize', type: 'number', default: 20

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
        false

    @on "click.tao-select-list-#{@taoId}", '.option', (e) =>
      $option = $ e.currentTarget
      option = $option.data('option')
      @trigger('select', [option]) if option
      null

  _activeChanged: ->
    if @active
      @trigger 'show'
      @searchField.focus() if @searchable
      @_refreshScrollPosition()
    else
      @searchField.val ''
      @trigger 'hide'
      @trigger 'search', ['']

  setOptions: (options, totalSize) ->
    @options = options.slice 0, @maxListSize
    $list = @jq.find('.options-list').empty()

    if @options.length > 0
      @empty = false

      @_lastRenderGroup = null
      for option in @options
        if option.group && @_lastRenderGroup != option.group
          $list.append @_renderGroup(option.group)
        $list.append @_renderOption(option)

      @_refreshScrollPosition()
      @highlightFirstOption()
    else
      @empty = true
      @highlightedOption = null

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
    $option.find('.name').text(option.data.label || option.text)
    $option.find('.hint').text(option.data.hint) if option.data.hint
    $option.attr 'data-value', option.value
    $option

  _refreshTips: (totalSize) ->
    $tips = @jq.find('.tips')
    if totalSize && @options.length > 0 && totalSize > @options.length
      $tips.removeClass('hidden')
        .find('.size').text(totalSize - @options.length)
    else
      $tips.addClass('hidden')
        .find('.size').text('')

  _refreshScrollPosition: ->
    return unless @active

    @_reflow()

    $list = @jq.find('.list-wrapper')
    if @direction == 'up'
      $list.scrollTop $list[0].scrollHeight
    else
      $list.scrollTop 0

  highlightNextOption: ->
    if @highlightedOption
      method = if @direction == 'up' then 'prev' else 'next'
      $option = @jq.find(".option[data-value='#{@highlightedOption.value}']")[method]('.option')
      @highlightOption($option) if $option.length > 0
    else
      @highlightFirstOption()

  highlightPrevOption: ->
    if @highlightedOption
      method = if @direction == 'up' then 'next' else 'prev'
      $option = @jq.find(".option[data-value='#{@highlightedOption.value}']")[method]('.option')
      @highlightOption($option) if $option.length > 0
    else
      @highlightFirstOption()

  highlightFirstOption: ->
    @highlightOption @jq.find('.option:first')

  highlightOption: (option) ->
    if option instanceof Option
      $option = @jq.find(".option[data-value='#{option.value}']")
    else
      $option = option

    return false unless $option && !$option.hasClass('highlighted')
    $option.addClass('highlighted')
      .siblings('.option').removeClass('highlighted')
    @highlightedOption = $option.data 'option'

  setMaxHeight: (maxHeight) ->
    maxHeight = if maxHeight
      searchHeight = if @searchable then @jq.find('.search-input').outerHeight() else 0
      optionHeight = @jq.find('.options-list .option:first').outerHeight()
      Math.floor((maxHeight - searchHeight) / optionHeight) * optionHeight
    else
      ''

    @jq.find('.list-wrapper').css
      maxHeight: maxHeight

TaoComponent.register Tao.Form.Select.List
