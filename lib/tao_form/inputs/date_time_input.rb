module TaoForm
  module Inputs
    class DateTimeInput < ::SimpleForm::Inputs::DateTimeInput

      def input(wrapper_options = nil)
        merged_input_options = merge_wrapper_options(input_html_options, wrapper_options)
        input_options[:icon] = :arrow_right

        template.send(
          :"tao_#{input_type}_picker", @builder, attribute_name,
          input_options, merged_input_options
        )
      end

      private

      def use_html5_inputs?
        true
      end

    end
  end
end
