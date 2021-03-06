import $ from 'jquery'
import SelectListBaseElement from '../../shared/fields/select/list/base'

class SelectList extends SelectListBaseElement

  @attribute 'active', type: 'boolean', observe: true

  @attribute 'direction', default: 'down'

  _connected: ->
    super()

    @highlightedOption = null

  _bind: ->
    super()

    @on 'keydown', '.search-field', (e) =>
      if e.which == 13
        if @highlightedOption
          $option = @jq.find(".option[data-value='#{@highlightedOption.value}']")
            .addClass 'selected'
          @namespacedTrigger('select', [@highlightedOption, $option])
        false
      else if e.which == 27
        @namespacedTrigger 'cancel'
        false
      else if e.which == 38
        @highlightPrevOption()
        false
      else if e.which == 40
        @highlightNextOption()
        false

    @on 'mouseenter', '.option', (e) =>
      $option = $ e.currentTarget
      @highlightOption $option
      null

  _activeChanged: ->
    if @active
      @namespacedTrigger 'show'
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
    super arguments...
    if @options.length > 0
      @highlightFirstOption()
    else
      @highlightedOption = null

  setMaxHeight: (maxHeight) ->
    maxHeight = if maxHeight
      searchHeight = if @searchable then @jq.find('.search-input').outerHeight() else 0
      maxHeight - searchHeight
    else
      ''

    @jq.find('.list-wrapper').css
      maxHeight: maxHeight

  highlightNextOption: ->
    if @highlightedOption
      method = if @direction == 'up' then 'prevAll' else 'nextAll'
      $option = @jq.find(".option[data-value='#{@highlightedOption.value}']")[method]('.option:first')
      @highlightOption($option) if $option.length > 0
    else
      @highlightFirstOption()

  highlightPrevOption: ->
    if @highlightedOption
      method = if @direction == 'up' then 'nextAll' else 'prevAll'
      $option = @jq.find(".option[data-value='#{@highlightedOption.value}']")[method]('.option:first')
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

export default SelectList.register()
