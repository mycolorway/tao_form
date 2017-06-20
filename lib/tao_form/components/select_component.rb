require 'tao_form/components/select/result_component'
require 'tao_form/components/select/multiple_result_component'
require 'tao_form/components/select/list_component'

module TaoForm
  module Components
    class SelectComponent < FieldComponent

      attr_reader :choices, :html_options, :disabled, :multiple, :max_list_size, :block_for_render

      def initialize view, builder = nil, attribute_name = nil, choices = nil, options = {}, html_options = {}
        if builder.is_a? Hash
          if attribute_name.is_a? Hash
            options = builder
            html_options = attribute_name
          else
            options = {}
            html_options = builder
          end
          builder = nil
          attribute_name = nil
          choices = nil
        end

        super view, builder, attribute_name, options

        @choices = choices
        @max_list_size = options.delete(:max_list_size) || html_options.delete(:max_list_size)
        @disabled = html_options[:disabled].presence || false
        @multiple = @options.delete(:multiple) || html_options.delete(:multiple) || false

        html_options[:multiple] = @multiple
        html_options[:remote] ||= @options.delete(:remote)
        html_options[:searchable_size] ||= @options.delete(:searchable_size)

        if html_options[:remote].present? && html_options[:remote].is_a?(Hash)
          html_options[:remote] = html_options[:remote].to_json
        end

        @html_options = transform_html_options html_options
      end

      def render &block
        @block_for_render = block
        super
      end

      def render_result
        if multiple
          view.tao_multiple_select_result(
            builder, attribute_name, choices, options, disabled: disabled, &block_for_render
          )
        else
          view.tao_select_result(
            builder, attribute_name, choices, options,
            placeholder: placeholder, clearable: clearable, disabled: disabled, &block_for_render
          )
        end
      end

      def render_list
        view.tao_select_list max_list_size: max_list_size
      end

      def clearable
        @clearable ||= html_options.delete(:clearable) || options[:include_blank].present? || options[:prompt].present?
      end

      def placeholder
        @placeholder ||= if options.key?(:placeholder)
          options[:placeholder]
        elsif options[:include_blank].present? && options[:include_blank].is_a?(String)
          options[:include_blank]
        elsif options[:prompt].present? && options[:prompt].is_a?(String)
          options[:prompt]
        else
          t :placeholder
        end
      end

      def self.component_name
        :select
      end

      private

      def default_options
        {icon: :arrow_down}
      end

    end
  end
end
