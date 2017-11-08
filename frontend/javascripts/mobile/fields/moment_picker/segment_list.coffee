import $ from 'jquery'
import MomentPickerSegmentListBase from '../../../shared/fields/moment_picker/segment_list/base'

class MomentPickerSegmentList extends MomentPickerSegmentListBase

  @attribute 'clearable', type: 'boolean'

  _bind: ->
    super()

    @on 'click', '.link-clear', (e) =>
      @namespacedTrigger 'clear'
      null

  refreshHeight: ->
    return unless @activeSegment
    winHeight = $(window).height()
    offsetTop = @activeSegment.getBoundingClientRect().top

    @activeSegment.jq.css
      height: winHeight - offsetTop

export default MomentPickerSegmentList.register()
