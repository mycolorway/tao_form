module TaoForm
  module Components
    class DatetimePickerComponent < MomentPicker::Base

      def self.component_name
        :datetime_picker
      end

      def input_type
        :datetime
      end

      def segments
        [:year, :month, :date, :hour, {separatar: ':'}, :date ]
      end

    end
  end
end
