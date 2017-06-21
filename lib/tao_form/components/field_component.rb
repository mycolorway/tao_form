module TaoForm
  module Components
    class FieldComponent < TaoOnRails::Components::Base

      attr_reader :builder, :attribute_name

      def initialize view, builder = nil, attribute_name = nil, options = {}
        if builder.is_a? Hash
          options = builder
          builder = nil
          attribute_name = nil
        end

        super view, options
        @builder = builder
        @attribute_name = attribute_name
      end

    end
  end
end
