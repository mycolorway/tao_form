module TaoForm
  module Inputs
    class DateTimeInput < ::SimpleForm::Inputs::DateTimeInput

      def input(wrapper_options = nil)
        merged_html_options = merge_wrapper_options(input_html_options, wrapper_options)
        merged_component_options = component_options.merge(merged_html_options)
        template.send(
          :"tao_#{input_type}_picker", @builder, attribute_name, merged_component_options
        )
      end

      private

      def use_html5_inputs?
        true
      end

      def component_options
        @component_options ||= input_options.slice(
          :value_format, :display_format, :date_display_format, :time_display_format,
          :date_placeholder, :time_placeholder, :placeholder, :icon, :disabled,
          :value, :minute_step, :date_icon, :time_icon
        )
      end

    end
  end
end
