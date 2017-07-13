module TaoForm
  module Components
    class SwitchComponent < CheckBoxComponent

      def self.component_name
        :switch
      end

      private

      def default_options
        {class: 'tao-switch'}
      end

    end
  end
end
