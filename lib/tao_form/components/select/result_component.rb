module TaoForm
  module Components
    module Select
      class ResultComponent < TaoForm::Components::FieldComponent

        attr_reader :choices, :html_options

        def initialize view, builder, attribute_name, choices = nil, options = {}, html_options = {}
          super view, builder, attribute_name, options
          @choices = choices
          @html_options = transform_html_options html_options

          if @html_options[:class].present?
            @html_options[:class] += " select-result"
          else
            @html_options[:class] = "select-result"
          end
        end

        def render &block
          if block_given?
            super
          elsif builder && attribute_name
            super {builder.select attribute_name, choices, options}
          end
        end

        def self.component_name
          :select_result
        end

      end
    end
  end
end
