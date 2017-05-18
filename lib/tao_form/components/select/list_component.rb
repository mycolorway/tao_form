module TaoForm
  module Components
    module Select
      class ListComponent < TaoOnRails::Components::Base

        def initialize view, options = {}
          super view, options

          if @options[:class].present?
            @options[:class] += " select-list"
          else
            @options[:class] = "select-list"
          end
        end

        def self.component_name
          :select_list
        end

      end
    end
  end
end
