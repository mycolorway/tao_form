module TaoForm
  module Components
    class MonthPickerComponent < MomentPicker::Base

      def input_type
        @input_type ||= :month
      end

      def segments
        @segments ||= %w(year month)
      end

      def default_segment
        @default_segment ||= :month
      end

      def self.component_name
        :month_picker
      end

    end
  end
end
