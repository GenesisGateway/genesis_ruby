# frozen_string_literal: true

require 'genesis_ruby/api/constants/currencies/iso4217'
require 'genesis_ruby/utils/money/conversions/amount_to_exponent'
require 'genesis_ruby/utils/money/conversions/exponent_to_amount'
require 'genesis_ruby/utils/money/format'

module GenesisRuby
  module Utils
    # Money Helper
    class MoneyFormat

      class << self

        # Convert major to minor currency format units
        def amount_to_exponent(amount, currency)
          strategy = GenesisRuby::Utils::Money::Conversions::AmountToExponent.new(
            amount,
            currency,
            GenesisRuby::Api::Constants::Currencies::Iso4217.fetch_exponent(currency)
          )

          GenesisRuby::Utils::Money::Format.new(strategy).convert
        end

        # Convert minor to major currency format units
        def exponent_to_amount(amount, currency)
          strategy = GenesisRuby::Utils::Money::Conversions::ExponentToAmount.new(
            amount,
            currency,
            GenesisRuby::Api::Constants::Currencies::Iso4217.fetch_exponent(currency)
          )

          GenesisRuby::Utils::Money::Format.new(strategy).convert
        end

      end

    end
  end
end
