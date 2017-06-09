#= require tao/form/shared/fields/moment_picker/segment_list/base

MomentPicker = Tao.Form.MomentPicker

class MomentPicker.SegmentList extends MomentPicker.SegmentListBase

  @attribute 'clearable', type: 'boolean'

  _bind: ->
    super

    @on 'click', '.link-clear', (e) =>
      @trigger 'clear'
      null

  refreshHeight: ->
    return unless @activeSegment
    winHeight = $(window).height()
    offsetTop = @activeSegment.getBoundingClientRect().top

    @activeSegment.jq.css
      height: winHeight - offsetTop

TaoComponent.register Tao.Form.MomentPicker.SegmentList
