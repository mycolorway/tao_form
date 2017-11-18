import MomentPickerElement from './moment_picker/element'

class MonthPickerElement extends MomentPickerElement

  @tag 'tao-month-picker'

  @attribute 'valueFormat', default: 'YYYY-MM'

  @attribute 'displayFormat', default: 'YYYY-MM'

export default MonthPickerElement.register()
