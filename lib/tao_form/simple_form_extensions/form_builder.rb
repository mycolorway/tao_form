# This extension separates inputs of TaoForm from other inputs,
# which makes it compatible with existing project.
module SimpleForm
  class FormBuilder

    private

    def find_input(attribute_name, options = {}, &block)
      column     = find_attribute_column(attribute_name)
      input_type = default_input_type(attribute_name, column, options)

      if block_given?
        SimpleForm::Inputs::BlockInput.new(self, attribute_name, column, input_type, options, &block)
      else
        find_mapping(input_type, options).new(self, attribute_name, column, input_type, options)
      end
    end

    def find_mapping(input_type, options = {})
      discovery_cache[input_type] ||=
      if mapping = self.class.mappings[input_type]
        mapping_override(mapping) || mapping
      else
        camelized = "#{input_type.to_s.camelize}Input"
        attempt_mapping_with_custom_namespace(camelized, options) ||
        attempt_mapping(camelized, Object) ||
        attempt_mapping(camelized, self.class) ||
        raise("No input found for #{input_type}")
      end
    end

    def attempt_mapping_with_custom_namespace(input_name, options = {})
      SimpleForm.custom_inputs_namespaces.each do |namespace|
        next if namespace == TaoForm.inputs_namespace && !options[:tao_form]
        if (mapping = attempt_mapping(input_name, namespace.constantize))
          return mapping
        end
      end

      nil
    end

  end
end
