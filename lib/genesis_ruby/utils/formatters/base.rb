# frozen_string_literal: true

module GenesisRuby
  module Utils
    module Formatters
      # Object Formatter Contract
      # ObjectFormatter iterate over each formatter with the given structure
      class Base

        # The Response keys that the formatter will be applied to
        def formatting_keys
          []
        end

        # The keys required for formatting the specific response key
        def required_keys
          []
        end

        # Format the given Response Key value
        def format_key(*_args)
          raise NotImplementedError, 'Format method is not implemented'
        end

        # Collect required key's values requires for the Response Object formatting
        # Ex. Amount to Major requires Currency
        def collect_required_key_values(response_object)
          required_key_values = []

          required_keys.each do |required_key|
            next unless response_object.include?(required_key.to_sym)

            required_key_values.push response_object[required_key.to_sym]
          end

          required_key_values
        end

      end
    end
  end
end
