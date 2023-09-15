require 'uri'
require 'date'

module GenesisRuby
  module Utils
    # Common Utils used all across the project
    class Common

      class << self

        # Deep compact over the given nested structure
        def deep_compact!(structure)
          structure.each do |element_key, element_value|
            deep_compact!(element_key) if element_key.is_a? Hash
            deep_compact!(element_value) if element_value.is_a?(Hash) || element_value.is_a?(Array)
          end

          compact_array! structure
          compact_hash! structure
        end

        # Compact over given Array
        def compact_array!(structure)
          return unless structure.is_a? Array

          structure.reject! do |element|
            element.is_a?(Array) || element.is_a?(Hash) ? element.empty? : element.nil?
          end
        end

        # Compact over given Hash
        def compact_hash!(structure)
          return unless structure.is_a? Hash

          structure.reject! do |_key, value|
            value.is_a?(Array) || value.is_a?(Hash) ? value.empty? : value.nil?
          end
        end

        # Deep compact empty over the given nested hash
        def deep_compact_empty!(structure)
          structure.each do |element_key, element_value|
            deep_compact_empty!(element_key) if element_key.is_a? Hash
            deep_compact_empty!(element_value) if element_value.is_a?(Hash) || element_value.is_a?(Array)
          end

          empty_compact_array!(structure)
          empty_compact_hash!(structure)
        end

        # Remove empty elements from an Array
        def empty_compact_array!(structure)
          return unless structure.is_a? Array

          structure.reject! do |element|
            element.is_a?(Array) || element.is_a?(Hash) || element.is_a?(String) ? element.empty? : element.nil?
          end
        end

        # Remove empty elements from an Hash
        def empty_compact_hash!(structure)
          return unless structure.is_a? Hash

          structure.reject! do |_key, value|
            value.is_a?(Array) || value.is_a?(Hash) || value.is_a?(String) ? value.empty? : value.nil?
          end
        end

        # Retrieve all constant values defined in the given module or class
        def constant_values(reference)
          constant_values = []

          reference.constants(false).each do |constant_value|
            value = reference.const_get constant_value

            constant_values.push value unless value.is_a?(Class) || value.is_a?(Module)
          end

          constant_values.sort
        end

        # Validates URL
        def valid_url?(url)
          uri = URI.parse(url)

          %w(http https).include?(uri.scheme) && !uri.host.nil? && !uri.host.to_s.empty?
        rescue StandardError
          false
        end

        # Parses string to DateTime
        def parse_date(date, formats)
          parsed_date = nil

          formats.each do |format|
            return Date.strptime(date, format)
          rescue StandardError
            parsed_date = nil
          end

          parsed_date
        end

      end

    end
  end
end
