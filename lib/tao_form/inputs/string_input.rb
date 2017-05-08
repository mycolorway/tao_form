module TaoForm
  module Inputs
    class StringInput < ::SimpleForm::Inputs::StringInput

      def input(wrapper_options = nil)
        origin_input = super
        prefix = options[:prefix].present? ? @builder.label(@attribute_name, options[:prefix], class: 'prefix') : ''
        suffix = options[:suffix].present? ? @builder.label(@attribute_name, options[:suffix], class: 'suffix') : ''

        field_class = ['text-field']
        field_class << 'text-field-with-prefix' if prefix.present?
        field_class << 'text-field-with-suffix' if suffix.present?

        template.content_tag(:div, "#{prefix}#{origin_input}#{suffix}".html_safe, class: field_class)
      end

    end
  end
end
