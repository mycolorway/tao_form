import MomentPickerElement from './moment_picker/element'

class TimePickerElement extends MomentPickerElement

  @tag 'tao-time-picker'

  @attribute 'valueFormat', default: 'HH:mm:ss'

  @attribute 'displayFormat', default: 'HH:mm'

export default TimePickerElement.register()
