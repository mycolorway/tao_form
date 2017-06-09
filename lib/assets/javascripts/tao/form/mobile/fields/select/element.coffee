#= require tao/form/shared/fields/select/element/base

class Tao.Form.Select.Element extends Tao.Form.Select.ElementBase

  _connected: ->
    @slideBox = @findComponent '.slide-box'
    super

  _bind: ->
    super

    @on 'click', '.select-result-delegate', (e) =>
      @_toggleActive()
      null

    @on 'click', '.header .link-close', (e) =>
      @active = false
      null

    @on 'click', '.header .button-ok', (e) =>
      @active = false
      null

    @on 'change', =>
      @list.refreshHeight() if @active
      @_refreshSelectedText()

  _bindListEvents: ->
    super

    @on 'selectOption', '.select-list', (e, option) =>
      if @multiple
        @list.reset()
      else
        @active = false
      null

  _resultReady: ->
    super
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

  _activeChanged: ->
    @slideBox.active = @active
    if @active
      @list.refreshHeight()
    else
      @list.reset()

TaoComponent.register Tao.Form.Select.Element
