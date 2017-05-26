module TaoForm
  module Components
    class FormComponent < TaoOnRails::Components::Base

      attr_reader :record, :html_options

      def initialize view, record, options
        super view, options
        @record = record
        @html_options = transform_html_options(@options.delete(:html) || {})
        @options[:wrapper] = :tao_mobile if view.request.variant.mobile?
      end

      def render &block
        view.content_tag tag_name, view.simple_form_for(record, options, &block), html_options
      end

      def self.component_name
        :form
      end

    end
  end
end
