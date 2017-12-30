module TaoForm
  module Components
    class SelectComponent < FieldComponent

      attr_reader :choices, :multiple, :result_options, :list_options, :block_for_render

      def initialize view, builder = nil, attribute_name = nil, choices = nil, options = {}
        super view, builder, attribute_name, options
        @choices = choices
        @multiple = @options[:multiple].presence || false

        init_result_options
        init_list_options
        init_remote_options
      end

      def render &block
        @block_for_render = block
        if view.request.variant.mobile?
          super
        else
          view.content_tag tag_name, html_options do
            view.concat render_result
            view.concat render_list
          end
        end
      end

      def render_result
        result_method = multiple ? :tao_multiple_select_result : :tao_select_result
        view.send(result_method, builder, attribute_name, choices, result_options, &block_for_render)
      end

      def render_list
        view.tao_select_list list_options
      end

      def clearable
        @clearable ||= options.delete(:clearable) || result_options[:include_blank].present? || result_options[:prompt].present?
      end

      def placeholder
        @placeholder ||= if (text = options.delete(:placeholder))
          text
        elsif result_options[:include_blank].present? && result_options[:include_blank].is_a?(String)
          result_options[:include_blank]
        elsif result_options[:prompt].present? && result_options[:prompt].is_a?(String)
          result_options[:prompt]
        else
          t :placeholder
        end
      end

      def self.component_name
        :select
      end

      private

      def init_result_options
        @result_options = options.extract!(
          :selected, :disabled, :option_disabled, :include_blank, :prompt, :include_hidden
        )

        unless multiple
          @result_options.merge!({
            placeholder: placeholder,
            clearable: clearable
          })
        end
      end

      def init_list_options
        @list_options = {
          max_list_size: options.delete(:max_list_size)
        }
      end

      def init_remote_options
        if options[:remote].present? && options[:remote].is_a?(Hash)
          options[:remote] = options[:remote].to_json
        end
      end

      def default_options
        {class: 'tao-select'}
      end

    end
  end
end
