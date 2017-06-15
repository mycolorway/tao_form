require 'tao_form/components/moment_picker/segments'
require 'tao_form/components/moment_picker/result_component'
require 'tao_form/components/moment_picker/segment_list_component'

module TaoForm
  module Components
    module MomentPicker
      class Base < TaoForm::Components::FieldComponent

        attr_reader :placeholder, :disabled, :html_options, :block_for_render, :value

        def initialize view, builder, attribute_name, options = {}, html_options = {}
          super view, builder, attribute_name, options
          @html_options = transform_html_options default_html_options, html_options
          @value = @html_options.delete(:value)
          @disabled = @html_options[:disabled].presence || false
        end

        def input_type
          # to be implemented
        end

        def segments
          # to be implemented
        end

        def default_segment
          # to be implemented
        end

        def render &block
          @block_for_render = block
          render_template 'moment_picker', &block
        end

        def render_result
          view.tao_moment_picker_result(
            builder, attribute_name, input_type: input_type, icon: options[:icon],
            placeholder: placeholder, disabled: disabled, value: value, &block_for_render
          )
        end

        def render_segment_list
          view.tao_moment_picker_segment_list segments: segments,
            default_segment: default_segment
        end

        def placeholder
          @placeholder ||= if options[:placeholder].present?
            options[:placeholder]
          else
            t :placeholder
          end
        end

        private

        def default_options
          {icon: :calendar}
        end

        def default_html_options
          {class: 'moment-picker'}
        end

      end
    end
  end
end
