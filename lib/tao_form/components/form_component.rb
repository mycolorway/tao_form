module TaoForm
  module Components
    class FormComponent < TaoOnRails::Components::Base

      attr_reader :record, :html_options

      def initialize view, record, options
        super view, options
        @record = record
        @html_options = transform_html_options(@options.delete(:html) || {}, default_html_options)
      end

      def render &block
        view.content_tag tag_name, view.simple_form_for(record, options, &block), html_options
      end

      def self.component_name
        :form
      end

      private

      def default_options
        {
          wrapper: view.request.variant.mobile? ? :tao_mobile : :tao_desktop,
          defaults: {tao_form: true}
        }
      end

      def default_html_options
        {class: 'tao-form'}
      end

    end
  end
end
