import { Component } from '@mycolorway/tao'
import $ from 'jquery'
import _ from 'lodash'

class SelectListBase extends Component

  @tag 'tao-select-list'

  @attribute 'empty', 'loading', 'searching', 'searchable', type: 'boolean'

  @attribute 'hiddenSize', type: 'number', observe: true

  @attribute 'maxListSize', type: 'number', default: 20

  _connected: ->
    @searchField = @jq.find('.search-field')
    @selectedOption ||= []
    @_bind()

  _disconnected: ->
    @off()

  _bind: ->
    @on 'input', '.search-field', _.debounce (e) =>
      val = @searchField.val()
      @searching = !!val
      @namespacedTrigger 'search', [val]
    , 200

    @on 'click', '.option', (e) =>
      $option = $ e.currentTarget
      $option.addClass 'selected'
      option = $option.data('option')
      @namespacedTrigger('select', [option, $option]) if option
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
    if _.findIndex(@selectedOption, (opt) -> opt.value == option.value) > -1
      $option.addClass('selected')
    $option

  reset: ->
    @searchField.val ''
    @searching = false
    @namespacedTrigger 'search', ['']

  selectOption: (option) ->
    return if _.find @selectedOption, (opt) -> opt.value == option.value
    @selectedOption.push option
    true

  unselectOption: (option) ->
    _.remove @selectedOption, (opt) -> opt.value == option.value
    true

  clearSelected: ->
    @selectedOption.length = 0

export default SelectListBase
