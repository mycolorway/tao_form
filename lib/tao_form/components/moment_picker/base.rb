require 'tao_form/components/moment_picker/segments'
require 'tao_form/components/moment_picker/result_component'
require 'tao_form/components/moment_picker/segment_list_component'

module TaoForm
  module Components
    module MomentPicker
      class Base < TaoForm::Components::FieldComponent

        attr_reader :placeholder, :disabled, :html_options

        def initialize view, builder, attribute_name, options = {}, html_options = {}
          super view, builder, attribute_name, options
          @disabled = html_options[:disabled].presence || false
          @html_options = transform_html_options merge_options default_html_options, html_options
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
          view.content_tag tag_name, html_options do
            render_result(&block) + render_segment_list
          end
        end

        def render_result &block
          view.tao_moment_picker_result(
            builder, attribute_name, input_type: input_type,
            placeholder: placeholder, disabled: disabled, &block
          )
        end

        def render_segment_list
          view.tao_moment_picker_segment_list segments: segments, default_segment: default_segment
        end

        def placeholder
          @placeholder ||= if options[:placeholder].present?
            options[:placeholder]
          else
            t :placeholder
          end
        end

        private

        def default_html_options
          {class: 'moment-picker'}
        end

      end
    end
  end
end
