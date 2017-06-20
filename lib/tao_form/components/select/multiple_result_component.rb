module TaoForm
  module Components
    module Select
      class MultipleResultComponent < ResultComponent

        def render &block
          if block_given?
            super
          elsif builder && attribute_name
            super {
              builder.select attribute_name, choices, options, {multiple: true}
            }
          end
        end

        def self.component_name
          :multiple_select_result
        end

      end
    end
  end
end
