#= require ./base

MomentPicker = Tao.Form.MomentPicker

class MomentPicker.SegmentList extends MomentPicker.SegmentListBase

  @attribute 'active', type: 'boolean', observe: true

  @attribute 'direction', default: 'down'

  @attribute 'needConfirm', type: 'boolean'

  _bind: ->
    super

    @on 'click', '.button-confirm', (e) ->
      @trigger 'momentSelect', [moment @momentData]
      null

  _activeChanged: ->
    @trigger('show') if @active

  _setMomentData: (momentData) ->
    super
    confirmDisabled = @jq.find('.segment-label:not(.selected)').length > 0
    @jq.find('.button-confirm').attr 'disabled', confirmDisabled
    @momentData

TaoComponent.register Tao.Form.MomentPicker.SegmentList
