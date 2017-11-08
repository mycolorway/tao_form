import MomentPickerElement from './moment_picker/element'

class DatePickerElement extends MomentPickerElement

  @tag 'tao-date-picker'

  @attribute 'valueFormat', default: 'YYYY-MM-DD'

  @attribute 'displayFormat', default: 'YYYY-MM-DD'

export default DatePickerElement.register()
