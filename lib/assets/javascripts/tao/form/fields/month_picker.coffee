#= require ./moment_picker

class Tao.Form.MonthPicker extends Tao.Form.MomentPicker.Element

  @tag 'tao-month-picker'

  @attribute 'valueFormat', default: 'YYYY-MM'

  @attribute 'displayFormat', default: 'YYYY-MM'

TaoComponent.register Tao.Form.MonthPicker
