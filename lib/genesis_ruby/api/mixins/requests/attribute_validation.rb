require 'genesis_ruby/errors/request_error'

module GenesisRuby
  module Api
    module Mixins
      module Requests
        # Request Class attribute validations
        # Reads the pre-set `validation_<attribute>` and perform validation on the fields
        module AttributeValidation

          protected

          # Perform validation
          def validate
            validate_required_fields
          end

          # Required Fields Accessor
          def required_fields
            @required_fields ||= []
          end

          # Required Fields Accessor
          def required_fields=(value)
            raise RequestError, 'Invalid value given for Required Fields! Allowed type Array.' unless value.is_a? Array

            @required_fields = value
          end

          private

          # Validated Required fields
          def validate_required_fields
            required_fields.each do |field_name|
              if null_or_empty_field?(field_name)
                raise ParameterError, "Empty (nil) for required parameter: #{field_name}"
              end
            end
          end

          # Validate if the given field_name is null or empty
          def null_or_empty_field?(field_name)
            field_value = __send__ field_name.to_sym

            return false if [Integer, Float, TrueClass, FalseClass, DateTime].any? { |type| field_value.is_a? type }

            field_value.nil? || field_value.empty?
          end

        end
      end
    end
  end
end
