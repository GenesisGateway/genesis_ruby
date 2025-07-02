# frozen_string_literal: true

module GenesisRuby
  module Api
    module Requests
      module Financial
        module GiftCards
          # Fashioncheque transactions are made using gift cards provided by Fashioncheque
          class Fashioncheque < Requests::Base::Financial

            include Api::Mixins::Requests::AddressInfoAttributes
            include Api::Mixins::Requests::Financial::DynamicDescriptorAttributes
            include Api::Mixins::Requests::Financial::GiftCardsAttributes
            include Api::Mixins::Requests::Financial::ReferenceAttributes
            include Api::Mixins::Requests::NonFinancial::Tokenization::TokenAttributes

            protected

            # Fashioncheque transaction type
            def transaction_type
              Api::Constants::Transactions::FASHIONCHEQUE
            end

            # Fashioncheque field validations
            def init_field_validations
              super

              required_fields.push *%i[transaction_id amount currency card_number]
            end

            # Fashioncheque parameters structure
            def payment_transaction_structure
              {
                card_number:               card_number,
                cvv:                       cvv,
                token:                     token,
                reference_id:              reference_id,
                billing_address:           billing_address_parameters_structure,
                shipping_address:          shipping_address_parameters_structure,
                dynamic_descriptor_params: dynamic_descriptor_structure
              }
            end

          end
        end
      end
    end
  end
end
