module TaoForm
  module Components
    class DatetimePickerComponent < FieldComponent

      attr_reader :disabled, :value, :date_picker_options, :time_picker_options

      def initialize view, builder, attribute_name, options = {}
        super view, builder, attribute_name, options
        @value = @options.delete(:value)
        @disabled = @options[:disabled].presence || false

        init_date_picker_options
        init_time_picker_options
      end

      def render &block
        if block_given?
          super
        else
          super {
            builder.send :datetime_field, attribute_name, {disabled: disabled, value: value}
          }
        end
      end

      def render_date_picker
        view.tao_date_picker date_picker_options do
          view.date_field_tag nil, nil, class: 'date-field', disabled: disabled
        end
      end

      def render_time_picker
        view.tao_time_picker time_picker_options do
          view.time_field_tag nil, nil, class: 'time-field', disabled: disabled
        end
      end

      def self.component_name
        :datetime_picker
      end

      private

      def init_date_picker_options
        @date_picker_options = {
          placeholder: options.delete(:date_placeholder),
          disabled: disabled
        }

        if options.key?(:date_icon)
          @date_picker_options[:date_icon] = options.delete(:date_icon)
        end
      end

      def init_time_picker_options
        @time_picker_options = {
          placeholder: options.delete(:time_placeholder),
          disabled: disabled
        }

        if options.key?(:time_icon)
          @time_picker_options[:time_icon] = options.delete(:time_icon)
        end

        if options.key?(:minute_step)
          @time_picker_options[:minute_step] = options.delete(:minute_step)
        end
      end

    end
  end
end
