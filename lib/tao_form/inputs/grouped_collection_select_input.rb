module TaoForm
  module Inputs
    class GroupedCollectionSelectInput < ::SimpleForm::Inputs::GroupedCollectionSelectInput

      def input(wrapper_options = nil)
        label_method, value_method = detect_collection_methods

        merged_input_options = merge_wrapper_options(input_html_options, wrapper_options)

        template.tao_select @builder, attribute_name, nil, input_options, merged_input_options do
          @builder.grouped_collection_select(
            attribute_name, grouped_collection, group_method, group_label_method,
            value_method, label_method, input_options
          )
        end
      end

    end
  end
end
