module TaoForm
  module Components
    module MomentPicker
      module Segments
        class MonthSegmentComponent < TaoForm::Components::MomentPicker::Segments::Base

          def self.component_name
            :moment_picker_month_segment
          end

          private

          def default_options
            merge_options(super, {
              class: 'tao-moment-picker-month-segment'
            })
          end

        end
      end
    end
  end
end
