module TaoForm
  module Inputs
    class BooleanInput < ::SimpleForm::Inputs::BooleanInput

      def input(wrapper_options = nil)
        merged_input_options = merge_wrapper_options(input_html_options, wrapper_options)

        if switch?
          input_content = template.tao_switch(
            @builder, attribute_name, merged_input_options,
            checked_value, unchecked_value
          )
        else
          input_content = template.tao_check_box(
            @builder, attribute_name, merged_input_options,
            checked_value, unchecked_value
          )
        end

        template.content_tag(:div, input_content, class: 'boolean-field')
      end

      private

      def switch?
        input_options[:switch]
      end
    end
  end
end
