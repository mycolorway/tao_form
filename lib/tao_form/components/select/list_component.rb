module TaoForm
  module Components
    module Select
      class ListComponent < TaoOnRails::Components::Base

        def self.component_name
          :select_list
        end

        private

        def default_options
          {class: 'tao-select-list select-list'}
        end

      end
    end
  end
end
