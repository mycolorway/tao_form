#= require tao/form/shared/fields/select/list/base

class Tao.Form.Select.List extends Tao.Form.Select.ListBase

  @attribute 'active', type: 'boolean', observe: true

  @attribute 'direction', default: 'down'

  _connected: ->
    super

    @highlightedOption = null

  _bind: ->
    super

    @on 'keydown', '.search-field', (e) =>
      if e.which == 13
        @trigger('selectOption', [@highlightedOption]) if @highlightedOption
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

  _activeChanged: ->
    if @active
      @trigger 'show'
      @searchField.focus() if @searchable
      @_refreshScrollPosition()
    else
      @reset()

  _refreshScrollPosition: ->
    return unless @active

    @reflow()

    $list = @jq.find('.list-wrapper')
    if @direction == 'up'
      $list.scrollTop $list[0].scrollHeight
    else
      $list.scrollTop 0

  setOptions: (options, totalSize) ->
    super
    if @options.length > 0
      @highlightFirstOption()
    else
      @highlightedOption = null

  setMaxHeight: (maxHeight) ->
    maxHeight = if maxHeight
      searchHeight = if @searchable then @jq.find('.search-input').outerHeight() else 0
      optionHeight = @jq.find('.options-list .option:first').outerHeight()
      Math.floor((maxHeight - searchHeight) / optionHeight) * optionHeight
    else
      ''

    @jq.find('.list-wrapper').css
      maxHeight: maxHeight

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

TaoComponent.register Tao.Form.Select.List
