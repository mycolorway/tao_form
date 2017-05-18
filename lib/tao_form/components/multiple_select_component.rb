module TaoForm
  module Components
    class MultipleSelectComponent < SelectComponent

      def render_field &block
        if block_given?
          view.capture(&block)
        else
          builder.select attribute_name, choices, options, multiple: true
        end
      end

      def render_result
        view.tao_multiple_select_result placeholder: placeholder, disabled: disabled
      end

      def self.component_name
        :multiple_select
      end

    end
  end
end
