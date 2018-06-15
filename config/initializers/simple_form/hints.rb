module SimpleForm
  module Components
    # Needs to be enabled in order to do automatic lookups.
    module Hints
      def hint(wrapper_options = nil)
        @hint ||= begin
          options[:hint].to_s.html_safe if options[:hint].present?
        end
      end
    end
  end
end
