#= require tao/form/shared/fields/moment_picker/segment_list/base

MomentPicker = Tao.Form.MomentPicker

class MomentPicker.SegmentList extends MomentPicker.SegmentListBase

  @attribute 'active', type: 'boolean', observe: true

  @attribute 'direction', default: 'down'

  _activeChanged: ->
    @trigger('tao:show') if @active

TaoComponent.register Tao.Form.MomentPicker.SegmentList
