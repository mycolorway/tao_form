module TaoForm
  module Components
    module Select
      class MultipleResultComponent < TaoForm::Components::FieldComponent

        attr_reader :choices, :field_options

        def initialize view, builder, attribute_name, choices = nil, options = {}
          super view, builder, attribute_name, options
          @choices = choices

          init_field_options
          if options[:sortable]
            values = builder.object.send(attribute_name)
            @choices = choices.sort_by { |c| values.index(c.second) || values.size }
          end
        end

        def render &block
          if block_given?
            super
          elsif builder && attribute_name
            super {
              builder.select attribute_name, choices, field_options, {
                disabled: options[:disabled],
                multiple: true
              }
            }
          end
        end

        def self.component_name
          :multiple_select_result
        end

        def sortable
          options[:sortable]
        end

        private

        def init_field_options
          @field_options = options.extract!(
            :selected, :include_blank, :prompt, :include_hidden
          )
          @field_options[:disabled] = options.delete(:option_disabled) if options.has_key?(:option_disabled)
        end

        def default_options
          {class: 'tao-multiple-select-result select-result'}
        end

      end
    end
  end
end
