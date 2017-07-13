module TaoForm
  module Components
    class TimePickerComponent < MomentPicker::Base

      def input_type
        @input_type ||= :time
      end

      def segments
        @segments ||= [:hour, {separator: ':'}, {name: :minute, step: options[:minute_step]}]
      end

      def default_segment
        @default_segment ||= :hour
      end

      def self.component_name
        :time_picker
      end

      private

      def default_options
        merge_options(super, {
          class: 'tao-time-picker',
          icon: :clock,
          minute_step: 5
        })
      end

    end
  end
end
