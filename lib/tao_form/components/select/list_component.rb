module TaoForm
  module Components
    module Select
      class ListComponent < TaoOnRails::Components::Base

        attr_reader :search_placeholder

        def initialize view, options = {}
          super view, options
          @search_placeholder = @options.delete(:search_placeholder)
        end

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
