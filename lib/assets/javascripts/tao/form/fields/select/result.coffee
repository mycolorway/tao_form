#= require tao/form/shared/fields/select/result/base

class Tao.Form.Select.Result extends Tao.Form.Select.ResultBase

  @attribute 'active', type: 'boolean'

  _connected: ->
    super
    @jq.attr('tabindex', '0') unless @disabled

  _bind: ->
    super

    @on 'click', (e) =>
      return if @disabled
      @trigger 'activeClick'

    @on 'keydown', (e) =>
      return if @disabled
      if e.which == 13
        @trigger 'enterPress'
        false
      else if e.which == 8 || e.which == 46
        @clear() && @trigger('clear')
        false
      else if e.which == 38
        @trigger 'arrowPress', ['up']
        false
      else if e.which == 40
        @trigger 'arrowPress', ['down']
        false

  _disabledChanged: ->
    if @disabled
      @jq.removeAttr 'tabindex'
    else
      @jq.attr 'tabindex', '0'

TaoComponent.register Tao.Form.Select.Result