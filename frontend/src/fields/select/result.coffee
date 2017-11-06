import SelectResultBaseElement from '../../../shared/fields/select/result/base'

class SelectResultElement extends SelectResultBaseElement

  @attribute 'active', type: 'boolean'

  _connected: ->
    super()
    @jq.attr('tabindex', '0') unless @disabled

  _bind: ->
    super()

    @on 'click', (e) =>
      return if @disabled
      @namespacedTrigger 'activeClick'

    @on 'keydown', (e) =>
      return if @disabled
      if e.which == 13
        @namespacedTrigger 'enterPress'
        false
      else if e.which == 8 || e.which == 46
        @clearSelected() && @namespacedTrigger('clear')
        false
      else if e.which == 38
        @namespacedTrigger 'arrowPress', ['up']
        false
      else if e.which == 40
        @namespacedTrigger 'arrowPress', ['down']
        false

  _disabledChanged: ->
    if @disabled
      @jq.removeAttr 'tabindex'
    else
      @jq.attr 'tabindex', '0'


export default SelectResultBaseElement.register()
