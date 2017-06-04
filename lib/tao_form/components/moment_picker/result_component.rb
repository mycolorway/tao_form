module TaoForm
  module Components
    module MomentPicker
      class ResultComponent < TaoForm::Components::FieldComponent

        attr_reader :input_type

        def initialize view, builder, attribute_name, options = {}
          super view, builder, attribute_name, options
          @input_type = options.delete(:input_type)
        end

        def render &block
          if block_given?
            super
          else
            super {builder.send :"#{input_type}_field", attribute_name, options}
          end
        end

        def self.component_name
          :moment_picker_result
        end

      end
    end
  end
end
