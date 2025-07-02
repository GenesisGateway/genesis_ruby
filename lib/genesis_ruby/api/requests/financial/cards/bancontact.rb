# frozen_string_literal: true

module GenesisRuby
  module Api
    module Requests
      module Financial
        module Cards
          #  Bancontact is a local Belgian debit card scheme. All Belgian debit cards are co-branded
          # Bancontact and Maestro.
          class Bancontact < Requests::Base::Financial

            include Api::Mixins::Requests::CustomerAddress::BillingInfoAttributes
            include Api::Mixins::Requests::CustomerAddress::ShippingInfoAttributes
            include Api::Mixins::Requests::Financial::AsyncAttributes

            protected

            # BCMC transaction type
            def transaction_type
              Api::Constants::Transactions::BANCONTACT
            end

            # Bancontact field validations
            def init_field_validations
              super

              required_fields.push *%i[transaction_id amount currency return_success_url return_failure_url
                billing_country]
              field_values.merge! currency:        'EUR',
                                  billing_country: 'BE'
            end

            # Bancontact transaction structure
            def payment_transaction_structure
              {
                return_success_url: return_success_url,
                return_failure_url: return_failure_url,
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
