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
            segment = segment.clone
            name = segment.delete(:name)
            opts = segment_options.merge segment
          else
            name = segment
            opts = segment_options
          end

          segment_class = "TaoForm::Components::MomentPicker::Segments::#{name.camelize}SegmentComponent".constantize
          segment_class.new(view, opts).render
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
