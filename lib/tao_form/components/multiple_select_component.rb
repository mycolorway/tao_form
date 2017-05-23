require 'tao_form/components/multiple_select/result_component'

module TaoForm
  module Components
    class MultipleSelectComponent < SelectComponent

      def render_result &block
        view.tao_multiple_select_result(
          builder, attribute_name, choices, options, disabled: disabled, &block
        )
      end

      def self.component_name
        :multiple_select
      end

    end
  end
end
