module TaoForm
  module Components
    module MomentPicker
      module Segments
        class MinuteSegmentComponent < Base

          attr_reader :step

          def initialize view, options = {}
            super view, options
            @step = options[:step].presence || 5
          end

          def self.component_name
            :moment_picker_minute_segment
          end

          private

          def default_options
            super.merge({label_format: t(:label, minute: '{{ minute }}')})
          end

        end
      end
    end
  end
end
