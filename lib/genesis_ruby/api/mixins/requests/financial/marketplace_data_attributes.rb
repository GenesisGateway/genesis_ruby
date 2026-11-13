# frozen_string_literal: true

require 'bigdecimal'
require 'genesis_ruby/api/constants/transactions/parameters/foreign_retailer_indicators'

module GenesisRuby
  module Api
    module Mixins
      module Requests
        module Financial
          # Marketplace Data attributes (Visa foreign retailer)
          module MarketplaceDataAttributes

            # Types accepted as a decimal number for the foreign retailer transaction amount
            MARKETPLACE_DATA_AMOUNT_TYPES = [Integer, Float, BigDecimal, String].freeze

            # Values are stored unchanged. The amount is set in major currency units.
            attr_accessor :foreign_retailer_indicator, :foreign_retailer_transaction_amount

            protected

            # Marketplace Data validations, executed after the generic request validation
            def validate_marketplace_data_attributes
              validate_foreign_retailer_indicator

              return if marketplace_data_empty?(foreign_retailer_transaction_amount)

              validate_marketplace_data_dependencies
              validate_foreign_retailer_transaction_amount
            end

            # Marketplace Data request structure. Never raises.
            def marketplace_data_attributes_structure
              {
                foreign_retailer_indicator:          marketplace_data_indicator_value,
                foreign_retailer_transaction_amount: marketplace_data_minor_amount
              }
            end

            private

            # Indicator must be a String equal to an allowed value (runs even without an amount)
            def validate_foreign_retailer_indicator
              value = foreign_retailer_indicator

              return if marketplace_data_empty?(value) || marketplace_data_valid_indicator?(value)

              raise ParameterError, format(
                'Parameter foreign_retailer_indicator is set to %{value}, but expected to be one of (%{allowed})',
                value:   value,
                allowed: foreign_retailer_indicators.all.join(', ')
              )
            end

            # Indicator, amount and currency presence (local, no generic helpers)
            def validate_marketplace_data_dependencies
              { foreign_retailer_indicator: foreign_retailer_indicator, amount: amount, currency: currency }
                .each do |field, value|
                  next unless marketplace_data_empty?(value)

                  raise ParameterError,
                        "foreign_retailer_transaction_amount is depending on: #{field}, which is empty (null)!"
                end
            end

            # Currency validity, type, sign, currency precision and upper bound checks
            def validate_foreign_retailer_transaction_amount
              validate_marketplace_data_currency

              decimal = marketplace_data_decimal(foreign_retailer_transaction_amount)

              validate_marketplace_data_decimal(decimal)
              validate_marketplace_data_upper_bound(decimal)
            end

            # Local currency guard: fetch_exponent returns 0 for unknown codes
            def validate_marketplace_data_currency
              return if Api::Constants::Currencies::Iso4217.valid?(currency)

              raise_marketplace_data_error "requires a valid ISO 4217 currency, #{currency} given"
            end

            # Type, sign and currency precision checks
            def validate_marketplace_data_decimal(decimal)
              raise_marketplace_data_error 'must be a valid decimal number' if decimal.nil?
              raise_marketplace_data_error 'must be greater than 0' unless decimal.positive?

              return if marketplace_data_integral?(decimal)

              raise_marketplace_data_error "must have max #{marketplace_data_exponent} decimal places for #{currency}"
            end

            # Upper bound check, compared in minor currency units
            def validate_marketplace_data_upper_bound(decimal)
              return if marketplace_data_to_minor(decimal) <= marketplace_data_to_minor(amount)

              raise_marketplace_data_error 'must be less than or equal to the transaction amount'
            end

            # Empty means nil or '' only; never calls .empty? on non-String values
            def marketplace_data_empty?(value)
              value.nil? || (value.is_a?(String) && value.empty?)
            end

            # Exact, case-sensitive match; any non-String value is invalid
            def marketplace_data_valid_indicator?(value)
              value.is_a?(String) && foreign_retailer_indicators.all.include?(value)
            end

            # Indicator for the request structure: only a non-empty String enters the tree
            def marketplace_data_indicator_value
              value = foreign_retailer_indicator

              return nil unless value.is_a?(String) && !value.empty?

              value
            end

            # Finite BigDecimal of the given value or nil when it is not a valid decimal number
            def marketplace_data_decimal(value)
              return nil unless MARKETPLACE_DATA_AMOUNT_TYPES.any? { |type| value.is_a?(type) }

              decimal = BigDecimal(value.to_s)

              decimal.finite? ? decimal : nil
            rescue ArgumentError, TypeError
              nil
            end

            # Currency exponent; call only after the currency is a valid ISO 4217 code
            def marketplace_data_exponent
              Api::Constants::Currencies::Iso4217.fetch_exponent(currency)
            end

            # Whether the decimal has no more decimal places than the currency exponent allows
            def marketplace_data_integral?(decimal)
              (decimal * (10**marketplace_data_exponent)).frac.zero?
            end

            # Same predicates as validation rules 5 to 8; guarantees the converter cannot raise
            def marketplace_data_convertible?(decimal)
              !decimal.nil? &&
                Api::Constants::Currencies::Iso4217.valid?(currency) &&
                decimal.positive? &&
                marketplace_data_integral?(decimal)
            end

            # Foreign amount in minor units or nil when it cannot be converted
            def marketplace_data_minor_amount
              return nil if marketplace_data_empty?(foreign_retailer_transaction_amount)

              decimal = marketplace_data_decimal(foreign_retailer_transaction_amount)

              return nil unless marketplace_data_convertible?(decimal)

              GenesisRuby::Utils::MoneyFormat.amount_to_exponent(decimal, currency)
            end

            # Integer minor-unit value for comparison
            def marketplace_data_to_minor(value)
              GenesisRuby::Utils::MoneyFormat.amount_to_exponent(value, currency).to_i
            end

            # Foreign retailer indicator constants
            def foreign_retailer_indicators
              Api::Constants::Transactions::Parameters::ForeignRetailerIndicators
            end

            # Raise a foreign_retailer_transaction_amount validation error
            def raise_marketplace_data_error(reason)
              raise ParameterError, "foreign_retailer_transaction_amount #{reason}"
            end

          end
        end
      end
    end
  end
end
