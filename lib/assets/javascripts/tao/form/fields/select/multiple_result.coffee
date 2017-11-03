#= require tao/form/shared/fields/select/multiple_result/base

class Tao.Form.Select.MultipleResult extends Tao.Form.Select.MultipleResultBase

  @attribute 'active', type: 'boolean'

  @attribute 'allSelected', type: 'boolean'

  _connected: ->
    super
    @linkAdd = @jq.find '.link-add'
    @linkAdd.attr('tabindex', '0') unless @disabled

  _bind: ->
    super

    @on 'click', '.link-add', (e) =>
      return if @disabled
      @namespacedTrigger 'activeClick'
      false

    @on 'keydown', '.link-add', (e) =>
      return if @disabled
      if e.which == 13
        @namespacedTrigger 'enterPress'
        false
      else if e.which == 38
        @namespacedTrigger 'arrowPress', ['up']
        false
      else if e.which == 40
        @namespacedTrigger 'arrowPress', ['down']
        false

  _disabledChanged: ->
    if @disabled
      @linkAdd.removeAttr 'tabindex'
    else
      @linkAdd.attr 'tabindex', '0'

  focus: ->
    @linkAdd.focus()

TaoComponent.register Tao.Form.Select.MultipleResult
