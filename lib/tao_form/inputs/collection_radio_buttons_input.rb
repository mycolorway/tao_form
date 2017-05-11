module TaoForm
  module Inputs
    class CollectionRadioButtonsInput < ::SimpleForm::Inputs::CollectionRadioButtonsInput

      def input(wrapper_options = nil)
        template.content_tag(:div, super, class: 'group-field radio-button-group-field')
      end

      protected

      def build_nested_boolean_style_item_tag(collection_builder)
        template.tao_radio_button {
          collection_builder.radio_button
        } + collection_builder.text
      end

    end
  end
end
