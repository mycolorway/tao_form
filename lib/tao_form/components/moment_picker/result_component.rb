module TaoForm
  module Components
    module MomentPicker
      class ResultComponent < TaoForm::Components::FieldComponent

        attr_reader :input_type, :value

        def initialize view, builder, attribute_name, options = {}
          @input_type = options.delete(:input_type)
          @value = options.delete(:value)
          super view, builder, attribute_name, options
        end

        def render &block
          if block_given?
            super
          elsif builder && attribute_name
            super {
              builder.send :"#{input_type}_field", attribute_name,
                {disabled: options[:disabled], value: value}
            }
          end
        end

        def self.component_name
          :moment_picker_result
        end

      end
    end
  end
end
