module TaoForm
  module Components
    module MomentPicker
      class SegmentListComponent < TaoOnRails::Components::Base

        attr_reader :segments

        def initialize view, options = {}
          @segments = options.delete(:segments)
          super view, options
        end

        def separatar_segment? segment
          segment.is_a?(Hash) && segment[:separatar].present?
        end

        def render_segment segment
          if segment.is_a? Hash
            options = segment
            name = segment.delete(:name)
          else
            options = {}
            name = segment
          end

          view.send :"tao_moment_picker_#{name}_segment", options
        end

        def self.component_name
          :moment_picker_segment_list
        end

      end
    end
  end
end
