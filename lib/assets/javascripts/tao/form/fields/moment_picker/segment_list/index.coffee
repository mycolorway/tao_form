#= require ./base

MomentPicker = Tao.Form.MomentPicker

class MomentPicker.SegmentList extends MomentPicker.SegmentListBase

  @attribute 'active', type: 'boolean', observe: true

  @attribute 'direction', default: 'down'

  _activeChanged: ->
    @trigger('show') if @active

TaoComponent.register Tao.Form.MomentPicker.SegmentList
