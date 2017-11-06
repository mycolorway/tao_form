import MomentPickerElementBase from './moment_picker/element/base'

class TimePickerElement extends MomentPickerElementBase

  @tag 'tao-time-picker'

  @attribute 'valueFormat', default: 'HH:mm:ss'

  @attribute 'displayFormat', default: 'HH:mm'

export default TimePickerElement.register()
