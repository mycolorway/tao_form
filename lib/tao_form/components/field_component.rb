module TaoForm
  module Components
    class FieldComponent < TaoOnRails::Components::Base

      attr_reader :builder, :attribute_name

      def initialize view, builder, attribute_name, options = {}
        super view, options
        @builder = builder
        @attribute_name = attribute_name
      end

    end
  end
end
