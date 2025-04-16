require 'genesis_ruby/api/constants/transactions/parameters/cash_payments/cash_payment_types'

module GenesisRuby
  module Api
    module Requests
      module Financial
        module CashPayments
          # Cash payment methods allow customers to pay bills and online purchases in cash at convenient
          # physical locations such as stores, banks, ATMs, even pharmacies in some countries.
          class Cash < Requests::Base::Financial

            include Api::Mixins::Requests::AddressInfoAttributes
            include Api::Mixins::Requests::DocumentAttributes
            include Api::Mixins::Requests::Financial::AsyncAttributes

            attr_accessor :payment_type

            protected

            # Cash transaction type
            def transaction_type
              Api::Constants::Transactions::CASH
            end

            # Cash field validations
            def init_field_validations
              super

              required_fields.push *%i[transaction_id return_success_url return_failure_url amount currency
               payment_type document_id billing_country]

              field_values.merge! currency:     %w(MXN),
                                  payment_type: Constants::Transactions::Parameters::CashPayments::CashPaymentTypes.all
            end

            # Cash request attributes structure
            def payment_transaction_structure
              {
                return_success_url: return_success_url,
                return_failure_url: return_failure_url,
                customer_email:     customer_email,
                customer_phone:     customer_phone,
                payment_type:       payment_type,
                document_id:        document_id,
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
