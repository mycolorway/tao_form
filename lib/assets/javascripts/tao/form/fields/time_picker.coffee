#= require ./moment_picker

class Tao.Form.TimePicker extends Tao.Form.MomentPicker.Element

  @tag 'tao-time-picker'

  @attribute 'valueFormat', default: 'HH:mm:ss'

  @attribute 'displayFormat', default: 'LT'

TaoComponent.register Tao.Form.TimePicker
