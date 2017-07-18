module TaoForm
  module Components
    module MomentPicker
      class ResultComponent < TaoForm::Components::FieldComponent

        attr_reader :input_type, :value, :icon, :placeholder

        def initialize view, builder = nil, attribute_name = nil, options = {}
          super view, builder, attribute_name, options
          @input_type = options.delete(:input_type)
          @value = options.delete(:value)
          @icon = options.delete(:icon)
          @placeholder = options.delete(:placeholder)
        end

        def render &block
          if block_given?
            super
          elsif builder && attribute_name
            super {
              builder.send :"#{input_type}_field", attribute_name, field_options
            }
          end
        end

        def self.component_name
          :moment_picker_result
        end

        private

        def default_options
          {class: 'tao-moment-picker-result'}
        end

        def field_options
          opts = {disabled: options[:disabled]}
          opts[:value] = value if value.present?
          opts
        end

      end
    end
  end
end
