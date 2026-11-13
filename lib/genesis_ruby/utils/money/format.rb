# frozen_string_literal: true

require 'genesis_ruby/errors/invalid_argument_error'

module GenesisRuby
  module Utils
    module Money
      # Money Helper
      class Format

        attr_accessor :strategy

        def initialize(strategy)
          @strategy = strategy
        end

        # Execute Convert Strategy
        def convert
          unless valid_amount_exponent?
            raise GenesisRuby::InvalidArgumentError, 'Currency exponent do not match the given amount'
          end

          strategy.convert
        end

        # Validate the given amount against the defined currency exponent
        def valid_amount_exponent?
          amount_sign, amount_digits, amount_base, amount_exponent = strategy.amount.split # rubocop:disable Lint/UselessAssignment
          decimal_places = strategy.amount.zero? ? 0 : amount_digits.length - amount_exponent

          !amount_sign.negative? && decimal_places <= strategy.currency_exponent
        end

      end
    end
  end
end
