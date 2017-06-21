module TaoForm
  module Components
    class CheckBoxComponent < FieldComponent

      attr_reader :checked_value, :unchecked_value, :checked, :disabled

      def initialize view, builder = nil, attribute_name = nil, options = {}
        super view, builder, attribute_name, options
        @checked_value = @options.delete(:checked_value)
        @unchecked_value = @options.delete(:unchecked_value)
        @checked = @options.delete(:checked)
        @disabled = @options.delete(:disabled)
      end

      def self.component_name
        :check_box
      end

      def render &block
        if block_given?
          super
        elsif builder && attribute_name
          super {
            builder.check_box attribute_name, {
              checked: checked,
              disabled: disabled
            }, checked_value, unchecked_value
          }
        end
      end

    end
  end
end
