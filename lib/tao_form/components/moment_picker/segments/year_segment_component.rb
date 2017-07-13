module TaoForm
  module Components
    module MomentPicker
      module Segments
        class YearSegmentComponent < Base

          def self.component_name
            :moment_picker_year_segment
          end

          private

          def default_options
            merge_options(super, {
              class: 'tao-moment-picker-year-segment',
              label_format: t(:label, year: '{{ year }}')
            })
          end

        end
      end
    end
  end
end
