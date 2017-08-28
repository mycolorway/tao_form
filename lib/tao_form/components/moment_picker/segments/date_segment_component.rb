module TaoForm
  module Components
    module MomentPicker
      module Segments
        class DateSegmentComponent < TaoForm::Components::MomentPicker::Segments::Base

          def self.component_name
            :moment_picker_date_segment
          end

          private

          def default_options
            merge_options(super, {
              class: 'tao-moment-picker-date-segment',
              label_format: t(:label, date: '{{ date }}')
            })
          end

        end
      end
    end
  end
end
