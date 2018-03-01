module TaoForm
  module Inputs
    class StringInput < ::SimpleForm::Inputs::StringInput

      def input(wrapper_options = nil)
        origin_input = super

        template.content_tag :div, class: field_class do
          template.concat field_prefix
          template.concat origin_input
          template.concat field_suffix
          template.concat(clear_link) if search_input?
        end
      end

      private

      def field_prefix
        @field_prefix ||= begin
          prefix = options[:prefix] || (search_input? ? template.tao_icon(:search) : nil)
          if prefix.present?
            @builder.label(@attribute_name, prefix, class: 'prefix')
          else
            ''
          end
        end
      end

      def field_suffix
        @field_suffix ||= if options[:suffix].present?
          @builder.label(@attribute_name, options[:suffix], class: 'suffix')
        else
          ''
        end
      end

      def field_class
        @field_class ||= begin
          classes = ['text-field']
          classes << 'text-field-with-prefix' if field_prefix.present?
          classes << 'text-field-with-suffix' if field_suffix.present?
          classes << 'not-empty' if @builder.object.send(attribute_name).present?
          classes
        end
      end

      def clear_link
        @clear_link ||= template.link_to 'javascript:;', class: 'link-clear' do
          template.concat template.tao_icon(:close)
        end
      end

      def search_input?
        input_type == :search
      end

    end
  end
end
