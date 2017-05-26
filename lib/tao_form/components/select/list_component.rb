module TaoForm
  module Components
    module Select
      class ListComponent < TaoOnRails::Components::Base

        def initialize view, options = {}
          super view, options

          if html_options[:class].present?
            html_options[:class] += " select-list"
          else
            html_options[:class] = "select-list"
          end
        end

        def self.component_name
          :select_list
        end

      end
    end
  end
end
