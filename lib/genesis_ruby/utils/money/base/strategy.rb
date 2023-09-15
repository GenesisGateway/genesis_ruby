require 'genesis_ruby/errors/invalid_argument_error'
require 'bigdecimal'

module GenesisRuby
  module Utils
    module Money
      module Base
        # Base Conversion Strategy class
        class Strategy

          attr_accessor :amount, :currency, :currency_exponent

          # Class constructor
          def initialize(amount, currency, currency_exponent)
            @amount            = parse_amount(amount)
            @currency          = currency
            @currency_exponent = currency_exponent
          end

          # Convert Strategy method
          def convert
            raise NotImplementedError
          end

          protected

          # Validate and parse amount into BigDecimal
          def parse_amount(amount)
            BigDecimal(amount.to_s)
          rescue StandardError
            raise InvalidArgumentError, 'Invalid amount value given.'
          end

        end
      end
    end
  end
end
