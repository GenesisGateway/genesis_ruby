# frozen_string_literal: true

require 'genesis_ruby/api/requests/base/financials/credit_card'

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
            include Mixins::Requests::Financial::GamingAttributes
            include Mixins::Requests::Financial::MotoAttributes
            include Mixins::Requests::Financial::PurposeOfPaymentAttributes
            include Mixins::Requests::Financial::SourceOfFundsAttributes

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

            # Payout request structure
            def payment_transaction_structure # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
              super.delete(:credential_on_file_settlement_date)
              super.delete(:scheme_tokenized)

              super.merge(
                source_of_funds_attributes_structure,
                {
                  gaming:                    gaming,
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
                  dynamic_descriptor_params: dynamic_descriptor_structure
                }
              )
            end

          end
        end
      end
    end
  end
end
