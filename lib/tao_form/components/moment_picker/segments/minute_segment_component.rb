module TaoForm
  module Components
    module MomentPicker
      module Segments
        class MinuteSegmentComponent < TaoForm::Components::MomentPicker::Segments::Base

          attr_reader :step

          def initialize view, options = {}
            super view, options
            @step = options.delete(:step)
          end

          def self.component_name
            :moment_picker_minute_segment
          end

          private

          def default_options
            merge_options(super, {
              class: 'tao-moment-picker-minute-segment',
              label_format: t(:label, minute: '{{ minute }}')
            })
          end

        end
      end
    end
  end
end
