module TaoForm
  module Components
    class DateRangePickerComponent < FieldComponent

      attr_reader :disabled, :value, :date_picker_options

      def initialize view, builder, attribute_name, options = {}
        super view, builder, attribute_name, options
        @value = @options.delete(:value)
        @disabled = @options[:disabled].presence || false

        init_date_picker_options
      end

      def render &block
        if block_given?
          super
        else
          super {
            builder.hidden_field attribute_name, field_options
          }
        end
      end

      def render_date_picker name
        opts = merge_options date_picker_options, {
          class: "#{name}-date-picker",
          placeholder: t("#{name}_placeholder")
        }
        view.tao_date_picker opts do
          view.date_field_tag nil, nil, class: "#{name}-date-field", disabled: disabled
        end
      end

      def self.component_name
        :date_range_picker
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

      def default_options
        {class: 'tao-date-range-picker'}
      end

      def field_options
        opts = {disabled: disabled}
        opts[:value] = value if value.present?
        opts
      end

    end
  end
end
