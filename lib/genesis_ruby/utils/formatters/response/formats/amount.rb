# frozen_string_literal: true

require 'genesis_ruby/utils/formatters/base'
require 'genesis_ruby/utils/money_format'

module GenesisRuby
  module Utils
    module Formatters
      module Response
        module Formats
          # Response Amount Formatter. Converts Minor Currency to Major currency format
          class Amount < Base

            # The Response keys that the formatter will be applied to
            def formatting_keys
              %w(amount leftover_amount)
            end

            # The keys required for formatting the specific response key
            def required_keys
              %w(currency)
            end

            # Format the given amount response key and its currency to major currency format
            def format_key(amount, currency)
              GenesisRuby::Utils::MoneyFormat.exponent_to_amount(amount, currency)
            rescue StandardError
              amount
            end

          end
        end
      end
    end
  end
end
