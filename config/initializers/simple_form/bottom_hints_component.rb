module SimpleForm
  module Components
    # Needs to be enabled in order to do automatic lookups
    module BottomHints
      # Name of the component method
      def bottom_hint(wrapper_options = nil)
        @bottom_hint ||= begin
          options[:bottom_hint].to_s.html_safe if options[:bottom_hint].present?
        end
      end

      # Used when the validation_hint is optional
      def has_validation_hint?
        bottom_hint.present?
      end
    end
  end
end

SimpleForm::Inputs::Base.send(:include, SimpleForm::Components::BottomHints)
