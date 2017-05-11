module TaoForm
  module Components
    class RadioButtonComponent < TaoOnRails::Components::Base

      attr_reader :builder, :attribute_name, :checked_value, :unchecked_value, :html_options

      def initialize view, builder = nil, attribute_name = nil, options = {}, checked_value = '1', unchecked_value = '0'
        super view, options
        @html_options = @options.delete(:html)
        @builder = builder
        @attribute_name = attribute_name
        @checked_value = checked_value
        @unchecked_value = unchecked_value
      end

      def self.component_name
        :radio_button
      end

    end
  end
end
