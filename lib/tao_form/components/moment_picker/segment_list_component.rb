module TaoForm
  module Components
    module MomentPicker
      class SegmentListComponent < TaoOnRails::Components::Base

        attr_reader :segments, :segment_options

        def initialize view, options = {}
          super view, options
          @segments = @options.delete(:segments)
          init_segment_options
        end

        def separator_segment? segment
          segment.is_a?(Hash) && segment[:separator].present?
        end

        def render_segment segment
          if segment.is_a? Hash
            name = segment.delete(:name)
            options = segment_options.merge segment
          else
            name = segment
            options = segment_options
          end

          view.send :"tao_moment_picker_#{name}_segment", options
        end

        def self.component_name
          :moment_picker_segment_list
        end

        private

        def default_options
          {class: 'tao-moment-picker-segment-list'}
        end

        def init_segment_options
          @segment_options = {
            disable_before: options.delete(:disable_before),
            disable_after: options.delete(:disable_after)
          }
        end

      end
    end
  end
end
