# frozen_string_literal: true

require 'genesis_ruby/api/constants/transactions/parameters/online_banking/iframe_targets'

module GenesisRuby
  module Api
    module Requests
      module Financial
        module OnlineBankingPayments
          # Online Banking TrustlySale transaction class
          class TrustlySale < Base::Financial

            include Api::Mixins::Requests::AddressInfoAttributes
            include Api::Mixins::Requests::BirthDateAttributes
            include Api::Mixins::Requests::Financial::AsyncAttributes
            include Api::Mixins::Requests::Financial::Business::BusinessAttributes

            attr_accessor :account_id, :user_id
            attr_reader :return_success_url_target

            # Allowed values for return_success_url_target
            def return_success_url_target=(value)
              allowed_options attribute:   __method__,
                              allowed:     Constants::Transactions::Parameters::OnlineBanking::IframeTargets.all,
                              value:       value,
                              allow_empty: true
            end

            protected

            # TrustlySale transaction type
            def transaction_type
              Api::Constants::Transactions::TRUSTLY_SALE
            end

            # TrustlySale field validations
            def init_field_validations # rubocop:disable Metrics/MethodLength
              super

              required_fields.push *%i[
                transaction_id
                remote_ip
                return_success_url
                return_failure_url
                amount
                currency
                customer_email
                billing_country
                account_id
              ]

              field_values.merge! billing_country: %w(AT BE CZ DK EE FI DE LV LT NL NO PL SK ES SE GB)
            end

            # TrustlySale parameters structure
            def payment_transaction_structure # rubocop:disable Metrics/MethodLength
              {
                return_success_url:        return_success_url,
                return_failure_url:        return_failure_url,
                return_success_url_target: return_success_url_target,
                customer_email:            customer_email,
                customer_phone:            customer_phone,
                user_id:                   user_id,
                birth_date:                birth_date,
                billing_address:           billing_address_parameters_structure,
                shipping_address:          shipping_address_parameters_structure,
                business_attributes:       business_attributes_structure,
                account_id:                account_id
              }
            end

          end
        end
      end
    end
  end
end
