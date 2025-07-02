# frozen_string_literal: true

require 'genesis_ruby/errors/object_formatter_error'

module GenesisRuby
  module Utils
    # Object Formatter component
    class ObjectFormatter

      # Available Formatters
      def formats
        @formats ||= []
      end

      # Add new formatter to the formatter array
      def formats=(formatters)
        raise ObjectFormatterError, 'Invalid array value given for Formats.' unless formatters.is_a? Array

        formats.push *formatters
      end

      # Apply all Formatter on the given object
      def format_structure(response_object)
        return format_hash(response_object) if response_object.is_a? Hash
        return format_array(response_object) if response_object.is_a? Array

        response_object
      end

      private

      # Format Object with Hash type
      def format_hash(response_object)
        response_object.each do |response_key, response_value|
          response_object[response_key] = if response_value.is_a?(Hash) || response_value.is_a?(Array)
                                            format_structure(response_value)
                                          else
                                            format_value(response_object, response_key, response_value)
                                          end
        end

        response_object
      end

      # Format Object with Array type
      def format_array(response_object)
        response_object.each do |response_value|
          format_structure(response_value)
        end
      end

      # Format Object key value
      def format_value(response_object, response_key, response_value)
        formats.each do |formatter|
          next unless formatter.formatting_keys.include?(response_key.to_s)

          required_values = formatter.collect_required_key_values(response_object)

          return response_value if required_values.count != formatter.required_keys.count

          return formatter.format_key(response_value, *required_values)
        end

        response_value
      end

    end
  end
end
