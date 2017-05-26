require 'tao_form/components/select/result_component'
require 'tao_form/components/select/list_component'

module TaoForm
  module Components
    class SelectComponent < FieldComponent

      attr_reader :choices, :html_options, :disabled, :max_list_size

      def initialize view, builder, attribute_name, choices = nil, options = {}, html_options = {}
        super view, builder, attribute_name, options
        @choices = choices
        @html_options = transform_html_options html_options
        @max_list_size = @html_options.delete(:'max-list-size')
        @disabled = @html_options[:disabled].presence || false
        @html_options[:remote] = @options.delete(:remote) if @options[:remote].present?

        if @html_options[:remote].present? && @html_options[:remote].is_a?(Hash)
          @html_options[:remote] = @html_options[:remote].to_json
        end
      end

      def render &block
        view.content_tag tag_name, nil, html_options do
          render_result(&block) + render_list
        end
      end

      def render_result &block
        view.tao_select_result(
          builder, attribute_name, choices, options,
          placeholder: placeholder, clearable: clearable, disabled: disabled, &block
        )
      end

      def render_list
        view.tao_select_list max_list_size: max_list_size
      end

      def clearable
        @clearable ||= options[:include_blank].present? || options[:prompt].present?
      end

      def placeholder
        @placeholder ||= if options[:placeholder].present?
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

    end
  end
end
