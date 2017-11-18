import MomentPickerResultBase from '../../shared/fields/moment_picker/result/base'

class MomentPickerResult extends MomentPickerResultBase

  @attribute 'active', type: 'boolean'

  _connected: ->
    super()
    @jq.attr('tabindex', '0') unless @disabled

  _bind: ->
    super()

    @on 'click', '.link-clear', (e) =>
      return if @disabled
      @clear() && @namespacedTrigger('clear')
      false

  _disabledChanged: ->
    if @disabled
      @jq.removeAttr 'tabindex'
    else
      @jq.attr 'tabindex', '0'

export default MomentPickerResult.register()
