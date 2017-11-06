import MomentPickerSegmentListBase from '../../../shared/fields/moment_picker/segment_list/base'

class MomentPickerSegmentList extends MomentPickerSegmentListBase

  @attribute 'active', type: 'boolean', observe: true

  @attribute 'direction', default: 'down'

  _activeChanged: ->
    @namespacedTrigger('show') if @active

export default MomentPickerSegmentList.register()
