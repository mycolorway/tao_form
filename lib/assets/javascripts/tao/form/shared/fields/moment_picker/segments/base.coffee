
class Tao.Form.MomentPicker.SegmentBase extends TaoComponent

  @attribute 'labelFormat'

  @attribute 'active', type: 'boolean'

  @attribute 'disableBefore', 'disableAfter', type: 'moment', observe: true

  segmentName: ''

  _connected: ->
    @momentData = {}
    @_bind()

  _disconnected: ->
    @off()

  _bind: ->

  setMomentData: (momentData) ->
    @momentData = momentData

  value: ->
    @momentData[@segmentName]

  label: ->
    format = @labelFormat || "{{ #{@segmentName} }}"
    compiled = _.template(format, interpolate: /{{([\s\S]+?)}}/g)
    compiled @momentData
