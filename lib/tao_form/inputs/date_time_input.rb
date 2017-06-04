module TaoForm
  module Inputs
    class DateTimeInput < ::SimpleForm::Inputs::DateTimeInput
      
      def input(wrapper_options = nil)
        merged_input_options = merge_wrapper_options(input_html_options, wrapper_options)
        
        template.send(:"tao_#{input_type}_picker", @builder, attribute_name, merged_input_options)
      end

    end
  end
end
