require 'genesis_ruby/utils/money/base/strategy'

module GenesisRuby
  module Utils
    module Money
      module Conversions
        # Amount To Exponent Money Conversion Strategy
        class AmountToExponent < GenesisRuby::Utils::Money::Base::Strategy

          # Convert amount to ISO-4217 minor currency unit
          def convert
            format '%d', amount * parse_amount(10**currency_exponent)
          end

        end
      end
    end
  end
end
