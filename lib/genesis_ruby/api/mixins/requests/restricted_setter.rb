require 'genesis_ruby/api/constants/date_time_formats'
require 'genesis_ruby/utils/common'

module GenesisRuby
  module Api
    module Mixins
      module Requests
        # Helper methods for restricting the available accessor's values
        module RestrictedSetter

          protected

          # Validation of the value's allowed values
          def allowed_options(attribute:, allowed:, value:, allow_empty: false, error_message: nil)
            return assign_instance_variable attribute, nil if allow_empty && value.to_s.empty?

            error_message = format(
              '%{error_message}%{method} accepts one of the following: %{allowed}',
              error_message: error_message ? "#{error_message} " : '',
              method:        attribute,
              allowed:       allowed.join(', ')
            )

            raise InvalidArgumentError, error_message unless allowed.include? value

            assign_instance_variable attribute, value
          end

          # Validation of the value's length
          def limited_string(attribute:, value:, min: nil, max: nil)
            len = value.to_s.length

            raise InvalidArgumentError, "#{attribute} value must be min #{min} chars long." if !min.nil? && len < min

            raise InvalidArgumentError, "#{attribute} value must be max #{max} chars long." if !max.nil? && len > max

            assign_instance_variable attribute, value
          end

          # Parses given date and assign it to the given attribute when it is valid
          def parse_date(attribute:, value:, formats: [], error_message: nil, allow_empty: false)
            return assign_instance_variable attribute, nil if allow_empty && value.to_s.empty?

            formats         = GenesisRuby::Api::Constants::DateTimeFormats.all if formats.empty?
            parsed_date     = GenesisRuby::Utils::Common.parse_date(value, formats)
            error_message ||= format(
              '%{method} accepts only valid date values in one of the following formats: %{formats}',
              method:  attribute,
              formats: formats.join(', ')
            )

            raise InvalidArgumentError, error_message unless parsed_date

            assign_instance_variable attribute.to_s.chomp, parsed_date
          end

          # Parses given value to_i and assign it to the given attribute
          def parse_int(attribute:, value:, allow_empty: false)
            return assign_instance_variable attribute, nil if allow_empty && value.to_s.empty?

            assign_instance_variable attribute, value.to_i
          end

          # Parses given value by validating if an array is given
          # Apply .to_s to every array value
          def parse_array_of_strings(attribute:, value:, allowed: [], allow_empty: false)
            raise InvalidArgumentError, "#{attribute} accepts only Array value." unless value.is_a?(Array)
            raise InvalidArgumentError, "#{attribute} empty value not allowed!" if !allow_empty && value.empty?

            parsed_value = value.map(&:to_s)

            unless allowed.empty?
              diff    = parsed_value - allowed
              message = "#{attribute} has invalid values #{diff.join(", ")}. Allowed: #{allowed.join(", ")}."

              raise InvalidArgumentError, message unless diff.empty?
            end

            assign_instance_variable attribute, value
          end

          private

          # Helper for assigning a attribute to the class instance
          def assign_instance_variable(attribute, value)
            instance_variable_set "@#{attribute.to_s.chomp "="}", value
          end

        end
      end
    end
  end
end
