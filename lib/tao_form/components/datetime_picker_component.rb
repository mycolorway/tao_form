module TaoForm
  module Components
    class DatetimePickerComponent < MomentPicker::Base

      def input_type
        @input_type ||= :datetime
      end

      def segments
        @segments ||= [
          :year, :month, :date,
          :hour, {separator: ':'}, {name: :minute, step: options[:minute_step]}
        ]
      end

      def default_segment
        @default_segment ||= :date
      end

      def self.component_name
        :datetime_picker
      end

      private

      def default_html_options
        super.merge({need_confirm: true})
      end

    end
  end
end
