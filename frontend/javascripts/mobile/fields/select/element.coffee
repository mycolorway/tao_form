import SelectElementBase from '../../../shared/fields/select/element/base'

class SelectElement extends SelectElementBase

  _connected: ->
    @slideBox = @findComponent '.slide-box'
    super()

  _bind: ->
    super()

    @slideBox.on 'tao:hide', (e) =>
      @active = false if @active
      null

    @on 'click', '.select-result-delegate', (e) =>
      @_toggleActive()
      null

    @on 'click', '.header .link-close', (e) =>
      @active = false
      null

    @on 'click', '.button-ok', (e) =>
      @active = false
      null

    @on 'tao:change', =>
      @_refreshListHeight() if @active
      @_refreshSelectedText()

  _bindListEvents: ->
    super()

    @on 'tao:select', '.select-list', (e, option) =>
      if @multiple
        @list.reset()
      else
        @active = false
      null

  _childComponentsReady: ->
    super()
    @_refreshSelectedText()

  _refreshSelectedText: ->
    text = if @multiple && @selectedOption.length > 0
      @selectedOption.map (opt) ->
        opt.text
      .join ', '
    else if @selectedOption
      @selectedOption.text
    else
      ''

    @jq.find('.select-result-delegate .selected-text').text text

  _refreshListHeight: ->
    $listWrapper = @list.jq.find('.list-wrapper')
    winHeight = $(window).height()
    offsetTop = $listWrapper[0].getBoundingClientRect().top
    buttonsHeight = @slideBox.jq.find('.slide-box-content > .buttons').outerHeight() || 0

    $listWrapper.css
      height: winHeight - offsetTop - buttonsHeight

  _activeChanged: ->
    @slideBox.active = @active
    if @active
      @_refreshListHeight()
    else
      @list.reset()

export default SelectElement.register()
