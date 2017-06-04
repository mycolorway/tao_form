#= require ./moment_picker

class Tao.Form.DatePicker extends Tao.Form.MomentPicker.Element

  @tag 'tao-date-picker'

  @attribute 'valueFormat', default: 'YYYY-MM-DD'

  @attribute 'displayFormat', default: 'LL'

TaoComponent.register Tao.Form.DatePicker
