module TaoForm
  module Components
    class DatetimePickerComponent < FieldComponent

      attr_reader :html_options, :disabled

      def initialize view, builder, attribute_name, options = {}, html_options = {}
        super view, builder, attribute_name, options
        @html_options = transform_html_options default_html_options, html_options
        @disabled = @html_options[:disabled].presence || false
      end

      def render &block
        if block_given?
          super
        else
          super {
            builder.send :datetime_field, attribute_name, {disabled: disabled}
          }
        end
      end

      def render_date_picker
        date_options = {
          icon: options[:icon],
          placeholder: options[:date_placeholder]
        }
        date_html_options = {disabled: disabled}
        view.tao_date_picker nil, nil, date_options, date_html_options do
          view.date_field_tag nil, nil, class: 'date-field', disabled: disabled
        end
      end

      def render_time_picker
        time_options = {
          icon: options[:icon],
          placeholder: options[:time_placeholder],
          minute_step: options[:minute_step]
        }
        time_html_options = {disabled: disabled}
        view.tao_time_picker nil, nil, time_options, time_html_options do
          view.time_field_tag nil, nil, class: 'time-field', disabled: disabled
        end
      end

      def self.component_name
        :datetime_picker
      end

      private

      def default_html_options
        {icon: :arrow_down}
      end

    end
  end
end
