#= require ./base

class Tao.Form.MomentPicker.Result extends Tao.Form.MomentPicker.ResultBase

  @attribute 'active', type: 'boolean'

  _connected: ->
    super
    @jq.attr('tabindex', '0') unless @disabled

  _bind: ->
    super

    @on 'click', (e) =>
      return if @disabled
      @trigger 'activeClick'

    @on 'click', '.link-clear', (e) =>
      return if @disabled
      @clear() && @trigger('clear')
      false

  _disabledChanged: ->
    if @disabled
      @jq.removeAttr 'tabindex'
    else
      @jq.attr 'tabindex', '0'

TaoComponent.register Tao.Form.MomentPicker.Result
