module TaoForm
  module Inputs
    class BooleanInput < ::SimpleForm::Inputs::BooleanInput

      def input(wrapper_options = nil)
        merged_html_options = merge_wrapper_options(input_html_options, wrapper_options)
        merged_component_options = component_options.merge(merged_html_options)

        input_content = template.send(switch? ? :tao_switch : :tao_check_box,
          @builder, attribute_name, merged_component_options
        )

        template.content_tag(:div, input_content, class: 'boolean-field')
      end

      private

      def switch?
        input_options[:switch]
      end

      def component_options
        @component_options ||= {
          disabled: input_options[:disabled],
          checked_value: checked_value,
          unchecked_value: unchecked_value
        }
      end
    end
  end
end
