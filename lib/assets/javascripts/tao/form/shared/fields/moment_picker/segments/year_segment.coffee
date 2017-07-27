#= require ./base

MomentPicker = Tao.Form.MomentPicker

class MomentPicker.YearSegment extends MomentPicker.SegmentBase

  @tag 'tao-moment-picker-year-segment'

  segmentName: 'year'

  _bind: ->
    @on 'click', '.year', (e) =>
      $year = $ e.currentTarget
      momentData = _.clone @momentData
      momentData.year = $year.data 'year'
      momentData.month = null
      momentData.date = null
      @namespacedTrigger 'dataSelect', [momentData]

    @on 'click', '.link-prev-years, .link-next-years', (e) =>
      momentData = _.clone @momentData
      if $(e.currentTarget).is('.link-prev-years')
        momentData['year'] -= 9
      else
        momentData['year'] += 9
      momentData.month = null
      momentData.date = null
      @namespacedTrigger 'dataRefresh', [momentData]

  setMomentData: (momentData) ->
    super

    if _.isNil @value()
      momentData.year = moment().year()
      @namespacedTrigger 'dataRefresh', [momentData]
      return false

    @_render()

  _render: ->
    $yearList = @jq.find('.year-list').empty()

    start = @value() - 4
    end = @value() + 4
    currentYear = moment().year()
    for year in [start..end]
      $year = $ '<a>',
        href: 'javascript:;'
        class: 'year'
        'data-year': year
        text: year

      $year.addClass('current') if year == currentYear
      $year.addClass('selected') if year == @value()
      $year.appendTo $yearList

TaoComponent.register MomentPicker.YearSegment
