module TaoForm
  module Inputs
    class CollectionCheckBoxesInput < ::SimpleForm::Inputs::CollectionCheckBoxesInput

      def input(wrapper_options = nil)
        template.content_tag(:div, super, class: 'group-field checkbox-group-field')
      end

      protected

      def build_nested_boolean_style_item_tag(collection_builder)
        template.tao_check_box {
          collection_builder.check_box
        } + collection_builder.text
      end

    end
  end
end
