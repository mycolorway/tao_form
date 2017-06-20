module TaoForm
  module Components
    class CheckBoxComponent < FieldComponent

      attr_reader :checked_value, :unchecked_value, :checked

      def initialize view, builder = nil, attribute_name = nil, options = {}, checked_value = '1', unchecked_value = '0'
        super view, builder, attribute_name, options
        @checked = @options.delete(:checked)
        @checked_value = checked_value
        @unchecked_value = unchecked_value
      end

      def self.component_name
        :check_box
      end

      def render &block
        if block_given?
          super
        elsif builder && attribute_name
          super {
            builder.check_box attribute_name, {checked: checked}, checked_value, unchecked_value
          }
        end
      end

    end
  end
end
