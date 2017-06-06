#= require ./moment_picker

class Tao.Form.DatetimePicker extends Tao.Form.MomentPicker.Element

  @tag 'tao-datetime-picker'

  @attribute 'valueFormat', default: 'YYYY-MM-DD HH:mm:ss'

  @attribute 'displayFormat', default: 'LLL'

TaoComponent.register Tao.Form.DatetimePicker
