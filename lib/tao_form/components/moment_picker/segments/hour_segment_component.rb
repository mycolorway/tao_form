module TaoForm
  module Components
    module MomentPicker
      module Segments
        class HourSegmentComponent < Base

          def self.component_name
            :moment_picker_hour_segment
          end

          private

          def default_options
            merge_options(super, {
              class: 'tao-moment-picker-hour-segment',
              label_format: t(:label, hour: '{{ hour }}')
            })
          end

        end
      end
    end
  end
end
