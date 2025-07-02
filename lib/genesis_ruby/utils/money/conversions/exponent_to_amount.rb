# frozen_string_literal: true

require 'genesis_ruby/utils/money/base/strategy'

module GenesisRuby
  module Utils
    module Money
      module Conversions
        # Amount To Exponent Money Conversion Strategy
        class ExponentToAmount < GenesisRuby::Utils::Money::Base::Strategy

          # Convert ISO-4217 minor currency unit to amount
          def convert
            format(
              "%.#{currency_exponent}f",
              (amount / parse_amount(10**currency_exponent)).truncate(currency_exponent)
            )
          end

        end
      end
    end
  end
end
