import MomentPickerElementBase from './moment_picker/element/base'

class MonthPickerElement extends MomentPickerElementBase

  @tag 'tao-month-picker'

  @attribute 'valueFormat', default: 'YYYY-MM'

  @attribute 'displayFormat', default: 'YYYY-MM'

export default MonthPickerElement.register()
