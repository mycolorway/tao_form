module TaoForm
  module Components
    class TimePickerComponent < MomentPicker::Base

      def self.component_name
        :time_picker
      end

      def input_type
        :time
      end

      def segments
        [:hour, {separatar: ':'}, :minute]
      end

    end
  end
end
