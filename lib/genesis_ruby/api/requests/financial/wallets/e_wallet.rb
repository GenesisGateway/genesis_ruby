# frozen_string_literal: true

require 'genesis_ruby/api/constants/transactions/parameters/wallets/e_wallet/payment_types'

module GenesisRuby
  module Api
    module Requests
      module Financial
        module Wallets
          # eWallet transaction that handles different e-wallet providers
          class EWallet < Requests::Base::Financial

            include Api::Mixins::Requests::AddressInfoAttributes
            include Api::Mixins::Requests::Financial::AsyncAttributes

            attr_accessor :payment_type

            # Billing Country custom accessor
            def billing_country
              return nil unless @billing_country

              @billing_country.to_s.upcase
            end

            protected

            # eWallet transaction type
            def transaction_type
              Api::Constants::Transactions::E_WALLET
            end

            # eWallet field validations
            def init_field_validations # rubocop:disable Metrics/MethodLength
              super

              required_fields.push *%i[
                transaction_id payment_type return_success_url return_failure_url amount currency billing_country
              ]

              field_values.merge! currency:     'INR',
                                  payment_type: Api::Constants::Transactions::Parameters::Wallets::EWallet::
                                      PaymentTypes.all

              field_value_dependencies.merge!(
                {
                  billing_country: {
                    US: %i[billing_state],
                    CA: %i[billing_state]
                  }
                }
              )
            end

            # eWallet request structure
            def payment_transaction_structure
              {
                payment_type:       payment_type,
                return_success_url: return_success_url,
                return_failure_url: return_failure_url,
                customer_email:     customer_email,
                customer_phone:     customer_phone,
                billing_address:    billing_address_parameters_structure,
                shipping_address:   shipping_address_parameters_structure
              }
            end

          end
        end
      end
    end
  end
end
