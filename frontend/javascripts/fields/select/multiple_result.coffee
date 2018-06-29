import SelectMultipleResultBaseElement from '../../shared/fields/select/multiple_result/base'

class SelectMultipleResultElement extends SelectMultipleResultBaseElement

  @attribute 'active', type: 'boolean'

  @attribute 'sortable', tyoe: 'boolean', default: false

  _connected: ->
    super()
    @linkAdd = @jq.find '.link-add'
    @linkAdd.attr('tabindex', '0') unless @disabled

  _bind: ->
    super()

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

    @on 'tao-sortable:sortEnd', '.tao-sortable', (e, $item) =>
      $option = @field.find("option[value='#{$item.data('value')}']")

      if $item.next().is('.selected-item')
        $prevOption = @field.find("option[value='#{$item.next().data('value')}']")
        $prevOption.before $option
      else if $item.prev().is('.selected-item')
        $nextOption = @field.find("option[value='#{$item.prev().data('value')}']")
        $nextOption.after $option

  _disabledChanged: ->
    if @disabled
      @linkAdd.removeAttr 'tabindex'
    else
      @linkAdd.attr 'tabindex', '0'

  _insertItem: ($item) ->
    @linkAdd.before $item

  focus: ->
    @linkAdd.focus()

export default SelectMultipleResultElement.register()
