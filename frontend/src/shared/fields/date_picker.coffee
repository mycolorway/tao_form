import MomentPickerElementBase from './moment_picker/element/base'

class DatePickerElement extends MomentPickerElementBase

  @tag 'tao-date-picker'

  @attribute 'valueFormat', default: 'YYYY-MM-DD'

  @attribute 'displayFormat', default: 'YYYY-MM-DD'

export default DatePickerElement.register()
