module TaoForm
  module Inputs
    class DateRangeInput < ::SimpleForm::Inputs::Base

      def input(wrapper_options = nil)
        merged_html_options = merge_wrapper_options(input_html_options, wrapper_options)
        merged_component_options = component_options.merge(merged_html_options)
        template.tao_date_range_picker(
          @builder, attribute_name, merged_component_options
        )
      end

      private

      def use_html5_inputs?
        true
      end

      def component_options
        @component_options ||= input_options.slice(
          :date_value_format, :date_display_format, :date_placeholder,
          :disabled, :value, :date_icon
        )
      end

    end
  end
end
