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
            super.merge({label_format: t(:label, year: '{{ year }}')})
          end

        end
      end
    end
  end
end
