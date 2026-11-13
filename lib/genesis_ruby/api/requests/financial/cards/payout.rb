# frozen_string_literal: true

require 'genesis_ruby/api/requests/base/financials/credit_card'
require 'genesis_ruby/api/constants/transactions/parameters/money_transfer/purpose_of_payments'

module GenesisRuby
  module Api
    module Requests
      module Financial
        module Cards
          # Payouts are credits without a reference transaction and as such are highly regulated
          # and need specific gateway terminal configuration
          class Payout < Requests::Base::Financials::CreditCard

            include Mixins::Requests::AddressInfoAttributes
            include Mixins::Requests::BirthDateAttributes
            include Mixins::Requests::DigitalAssetTypeAttributes
            include Mixins::Requests::DocumentAttributes
            include Mixins::Requests::Financial::Cards::FxRateAttributes
            include Mixins::Requests::Financial::CryptoAttributes
            include Mixins::Requests::Financial::CustomerIdentificationAttributes
            include Mixins::Requests::Financial::DynamicDescriptorAttributes
            include Mixins::Requests::Financial::MoneyTransferPayoutAttributes
            include Mixins::Requests::Financial::MotoAttributes
            include Mixins::Requests::Financial::PurposeOfPaymentAttributes
            include Mixins::Requests::Financial::SourceOfFundsAttributes

            # Credential on file settlement date is not supported by the Payout transaction
            def credential_on_file_settlement_date=(_value)
              raise ParameterError, "Parameter #{__method__} is not supported by the Payout transaction"
            end

            # Scheme tokenized is not supported by the Payout transaction
            def scheme_tokenized=(_value)
              raise ParameterError, "Parameter #{__method__} is not supported by the Payout transaction"
            end

            protected

            # Payout Transaction Type
            def transaction_type
              GenesisRuby::Api::Constants::Transactions::PAYOUT
            end

            # Payout Field validations
            def init_field_validations
              super

              required_fields.push *%i[card_holder card_number expiration_month expiration_year]

              field_value_dependencies.merge! required_tokenization_fields_conditional
            end

            # Payout accepts the Visa and the Mastercard Money Transfer purpose of payment values
            def allowed_purpose_of_payment_values
              super | Api::Constants::Transactions::Parameters::MoneyTransfer::PurposeOfPayments.all
            end

            # Payout request structure
            def payment_transaction_structure # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
              parent_structure = super

              parent_structure.delete :credential_on_file_settlement_date
              parent_structure.delete :scheme_tokenized

              parent_structure.merge(
                source_of_funds_attributes_structure,
                {
                  moto:                      moto,
                  crypto:                    crypto,
                  digital_asset_type:        digital_asset_type,
                  purpose_of_payment:        purpose_of_payment,
                  customer_email:            customer_email,
                  customer_phone:            customer_phone,
                  birth_date:                birth_date,
                  document_id:               document_id,
                  fx_rate_id:                fx_rate_id,
                  billing_address:           billing_address_parameters_structure,
                  shipping_address:          shipping_address_parameters_structure,
                  customer_identification:   customer_identification_attributes_structure,
                  dynamic_descriptor_params: dynamic_descriptor_structure,
                  money_transfer:            money_transfer_payout_attributes_structure
                }
              )
            end

          end
        end
      end
    end
  end
end
