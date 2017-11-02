
class Tao.Form.MomentPicker.SegmentListBase extends TaoComponent

  @tag 'tao-moment-picker-segment-list'

  @attribute 'defaultSegment'

  _connected: ->
    @segments = @jq.find('.tao-moment-picker-segment').get()
    @momentData = null

    @_bind()

  _disconnected: ->
    @off()

  _bind: ->
    @on 'click', '.segment-label', (e) =>
      segment = $(e.currentTarget).data('segment')
      @_setActiveSegment segment
      null

    @on 'tao:dataSelect', '.tao-moment-picker-segment', (e, momentData) =>
      @_setMomentData momentData
      @_activateNextSegment()

    @on 'tao:dataRefresh', '.tao-moment-picker-segment', (e, momentData) =>
      @_setMomentData momentData

  setMoment: (m) ->
    m = null unless m && moment.isMoment(m)
    momentData = {}

    @segments.forEach (segment) ->
      momentData[segment.segmentName] = if m
        m[segment.segmentName]()
      else
        null

    @_setActiveSegment @defaultSegment
    @_setMomentData momentData
    m

  _findSegmentLabel: (segment) ->
    segment = @_findSegment(segment) if typeof segment == 'string'
    @jq.find(".segment-label[data-segment='#{segment.segmentName}']")

  _findSegment: (segmentName) ->
    if segmentName instanceof Tao.Form.MomentPicker.SegmentBase
      return segmentName
    _.find @segments, (segment) -> segment.segmentName == segmentName

  _setMomentData: (momentData) ->
    for segment in @segments
      break if segment.setMomentData(_.clone(momentData)) == false
      $label = @_findSegmentLabel(segment)
      if !_.isNil segment.value()
        $label.addClass 'selected'
          .find('.value').text segment.label()
      else
        $label.removeClass 'selected'
          .find('.value').text ''

    @momentData = momentData
    @namespacedTrigger 'select', [moment(@momentData)]

  _setActiveSegment: (segment) ->
    segment = @_findSegment(segment) if typeof segment == 'string'
    return if segment == @activeSegment

    if @activeSegment
      @_findSegmentLabel(@activeSegment).removeClass 'active'
      @activeSegment.active = false

    @_findSegmentLabel(segment).addClass 'active'
    segment.active = true
    @activeSegment = segment

  _activateNextSegment: ->
    segment = _.find @segments, (s) => _.isNil @momentData[s.segmentName]
    if segment
      @_setActiveSegment segment
    else if @activeSegment
      if ($segment = @activeSegment.jq.next('.tao-moment-picker-segment')).length > 0
        @_setActiveSegment $segment.get(0)
      else
        @namespacedTrigger 'select', [moment(@momentData), true]
    else
      @_setActiveSegment @segments[0]
