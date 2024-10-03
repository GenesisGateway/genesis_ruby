require 'genesis_ruby/errors/request_error'

module GenesisRuby
  module Api
    module Mixins
      module Requests
        # Request Class attribute validations
        # Reads the pre-set `validation_<attribute>` and perform validation on the fields
        module AttributeValidation # rubocop:disable Metrics/ModuleLength

          protected

          # Perform validation
          def validate
            validate_required_fields required_fields
            validate_field_values field_values
            validate_field_value_dependencies field_value_dependencies
          end

          # Required Fields Accessor
          def required_fields
            @required_fields ||= []
          end

          # Required Fields Accessor
          def required_fields=(value)
            raise RequestError, 'Invalid value given for Required Fields! Allowed: Array.' unless value.is_a? Array

            @required_fields = value
          end

          # Field Values Accessor
          def field_values
            @field_values ||= {}
          end

          # Field Values Accessor
          def field_values=(value)
            raise RequestError, 'Invalid value given for Field Values! Allowed: Hash.' unless value.is_a? Hash

            @field_values = value
          end

          # Field Value Dependencies Accessor
          def field_value_dependencies
            @field_value_dependencies ||= {}
          end

          # Field Value Dependencies Accessor
          def field_value_dependencies=(value)
            unless value.is_a? Hash
              raise RequestError, 'Invalid value given for Required Field Conditional! Allowed: Hash.'
            end

            @field_value_dependencies = value
          end

          private

          # Validated Required fields
          def validate_required_fields(required_fields)
            required_fields.each do |field_name|
              if null_or_empty_field?(field_name)
                raise ParameterError, "Empty (nil) for required parameter: #{field_name}"
              end
            end
          end

          # Validate Required Field Values
          def validate_field_values(field_values)
            field_values.each do |field_name, field_value|
              # Allow optional attributes by bypassing null or empty field values
              next if null_or_empty_field? field_name

              # Validate against Array set of values
              next if allowed_array field_name, field_value

              # Validate against a value
              allowed_value field_name, field_value
            end
          end

          # Validate Required Field Conditional
          # Validates if given field
          def validate_field_value_dependencies(required_field_conditional) # rubocop:disable Metrics/MethodLength
            required_field_conditional.each do |field_name, value_dependencies|
              # Allow optional attributes
              next if null_or_empty_field? field_name

              unless value_dependencies.is_a?(Hash) || value_dependencies.is_a?(Array)
                raise RequestError, 'Invalid value given for Required Field Conditional Dependencies! Allowed: Hash.'
              end

              if value_dependencies.is_a? Array
                group_field_dependencies field_name, value_dependencies

                next
              end

              loop_field_value_dependencies field_name, value_dependencies
            end
          end

          # Validate if the given field_name is null or empty
          def null_or_empty_field?(field_name)
            field_value = __send__ field_name.to_sym

            return false if [Integer, Float, TrueClass, FalseClass, DateTime].any? { |type| field_value.is_a? type }

            field_value.nil? || field_value.empty?
          end

          # Validates Field accessor against allowed values
          def allowed_array(field_name, allowed_values)
            return nil unless allowed_values.is_a? Array

            unless allowed_values.include?(__send__(field_name))
              raise ParameterError, format(
                'Parameter %{field} is set to %{field_value}, but expected to be one of (%{allowed})',
                field:       field_name,
                field_value: __send__(field_name),
                allowed:     allowed_values.join(', ')
              )
            end

            true
          end

          # Validates Field accessor against allowed value
          def allowed_value(field_name, allowed_value)
            return nil if __send__(field_name) == allowed_value

            raise ParameterError, format(
              'Required parameter %{field_name} is set to %{field_value}, but expected to be %{allowed_value}',
              field_name:    field_name,
              field_value:   __send__(field_name),
              allowed_value: allowed_value
            )
          end

          # Validate if given dependencies based on the field value satisfy the request
          def loop_field_value_dependencies(field_name, value_dependencies)
            value_dependencies.each do |value_depend, dependencies|
              next if __send__(field_name).to_s != value_depend.to_s

              group_field_dependencies field_name, dependencies if dependencies.is_a? Array
              group_field_value_dependencies field_name, dependencies if dependencies.is_a? Hash
            end
          end

          # Validates Group field dependencies
          # Check if all of the given array of attributes are set (not null or empty fields)
          def group_field_dependencies(field_name, fields)
            fields.each do |field|
              next unless null_or_empty_field? field

              raise ParameterError, format(
                '%{field_name} is depending on: %{field}, which is empty (null)!',
                field_name: field_name,
                field:      field
              )
            end
          end

          # Validates Group of attributes against given allowed values
          def group_field_value_dependencies(field_name, dependencies) # rubocop:disable Metrics/MethodLength
            dependencies.each do |field_depend, allowed_values|
              next if null_or_empty_field? field_depend

              next if allowed_values.include? __send__(field_depend)

              raise ParameterError, format(
                '%{field} with value %{field_value} is depending on: %{field_depend}, which is ' \
                  'expected to be one of (%{allowed})! Please refer the official documentation for %{trx_type} type.',
                field:        field_name,
                field_value:  __send__(field_name),
                field_depend: field_depend,
                allowed:      allowed_values.join(', '),
                trx_type:     self.class.name
              )
            end
          end

        end
      end
    end
  end
end
