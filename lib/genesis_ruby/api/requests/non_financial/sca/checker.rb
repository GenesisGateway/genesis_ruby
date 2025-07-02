# frozen_string_literal: true

require 'genesis_ruby/api/constants/transactions/parameters/non_financial/sca_exemptions'

module GenesisRuby
  module Api
    module Requests
      module NonFinancial
        module Sca
          # SCA Checker call is used for the determination whether SCA is required
          class Checker < Base::Versioned

            include Api::Mixins::Requests::Financial::MotoAttributes

            attr_reader :mit, :card_number
            attr_accessor :transaction_amount, :transaction_currency, :recurring_type, :transaction_exemption

            # SCA Checker constructor
            def initialize(configuration, _builder_interface = nil)
              super configuration

              self.request_path = "sca/checker/#{configuration.token}"
            end

            # Full card number or first 6 digits
            def card_number=(value)
              unless value.nil? || value.to_s =~ /\A\d{6,16}\Z/
                raise(
                  InvalidArgumentError,
                  'Invalid value for card_number. Allowed only digits with min length 6 and max length 16'
                )
              end

              @card_number = value.to_s
            end

            # Signifies whether a MIT (merchant initiated transaction) is performed
            def mit=(value)
              allowed_options attribute:     __method__,
                              value:         value,
                              allowed:       [true, false],
                              allow_empty:   true,
                              error_message: 'Accepts only boolean values'
            end

            protected

            # SCA Checker field validations
            def init_field_validations
              super

              required_fields.push *%i[card_number transaction_amount transaction_currency]
              field_values.merge! transaction_currency:  Constants::Currencies::Iso4217.all.map(&:upcase),
                                  recurring_type:        [Constants::Transactions::Parameters::Recurring::Types::
                                                              INITIAL,
                                                          Constants::Transactions::Parameters::Recurring::Types::
                                                              SUBSEQUENT],
                                  transaction_exemption: Constants::Transactions::Parameters::ScaExemptions.all
            end

            # SCA Checker request structure
            def request_structure
              {
                card_number:           card_number,
                transaction_amount:    transform_amount(transaction_amount, transaction_currency).to_i,
                transaction_currency:  transaction_currency,
                moto:                  moto,
                mit:                   mit,
                recurring_type:        recurring_type,
                transaction_exemption: transaction_exemption
              }
            end

          end
        end
      end
    end
  end
end
