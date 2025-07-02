# frozen_string_literal: true

require 'genesis_ruby/api/constants/non_financial/kyc/transaction_statuses'
require 'genesis_ruby/api/constants/non_financial/kyc/industry_types'
require 'genesis_ruby/api/constants/non_financial/kyc/order_sources'

module GenesisRuby
  module Api
    module Requests
      module NonFinancial
        module Kyc
          module Transaction
            # Create transaction type for KYC Non-Financial API services
            class Create < Api::Requests::Base::NonFinancial::Kyc::Base # rubocop:disable Metrics/ClassLength

              include Api::Mixins::Requests::Financial::PaymentAttributes
              include Api::Mixins::Requests::NonFinancial::Kyc::DepositLimitsAttributes
              include Api::Mixins::Requests::NonFinancial::Kyc::CustomerInformationAttributes
              include Api::Mixins::Requests::NonFinancial::Kyc::KycBillingInfoAttributes
              include Api::Mixins::Requests::NonFinancial::Kyc::KycShippingInfoAttributes
              include Api::Mixins::Requests::NonFinancial::Kyc::PaymentDetailsAttributes

              attr_accessor :session_id, :customer_username, :customer_unique_id, :customer_status,
                            :customer_loyalty_level, :customer_registration_ip_address,
                            :customer_registration_device_id, :transaction_unique_id,
                            :customer_ip_address, :customer_device_id,
                            :third_party_device_id, :device_fingerprint, :device_fingerprint_type,
                            :shopping_cart_items_count, :order_source, :merchant_website, :industry_type,
                            :customer_password, :custom_variable, :transaction_status

              attr_writer   :deposits_count, :withdrawals_count, :current_balance, :rule_context

              # Initializes the Create Transaction Request
              def initialize(configuration, _builder_interface = nil)
                super configuration

                self.request_path = 'create_transaction'
              end

              # Returns customer registration date
              def customer_registration_date
                @customer_registration_date&.strftime GenesisRuby::Api::Constants::DateTimeFormats::YYYY_MM_DD_ISO_8601
              end

              # Sets customer registration date
              def customer_registration_date=(value)
                parse_date attribute: __method__, value: value, allow_empty: true
              end

              # Returns the first deposit date
              def first_deposit_date
                @first_deposit_date&.strftime GenesisRuby::Api::Constants::DateTimeFormats::YYYY_MM_DD_ISO_8601
              end

              # Sets the first deposit date
              def first_deposit_date=(value)
                parse_date attribute: __method__, value: value, allow_empty: true
              end

              # Returns the first withdrawal date
              def first_withdrawal_date
                @first_withdrawal_date&.strftime GenesisRuby::Api::Constants::DateTimeFormats::YYYY_MM_DD_ISO_8601
              end

              # Sets the first withdrawal date
              def first_withdrawal_date=(value)
                parse_date attribute: __method__, value: value, allow_empty: true
              end

              # Returns the local time in the format YYYY-MM-DD HH:MM:SS
              def local_time
                @local_time&.strftime GenesisRuby::Api::Constants::DateTimeFormats::YYYY_MM_DD_H_I_S
              end

              # Sets the local time
              def local_time=(value)
                parse_date attribute: __method__, value: value, allow_empty: true
              end

              # Returns the transaction created at date in the format YYYY-MM-DD HH:MM:SS
              def transaction_created_at
                @transaction_created_at&.strftime GenesisRuby::Api::Constants::DateTimeFormats::YYYY_MM_DD_H_I_S
              end

              # Sets the transaction created at date
              def transaction_created_at=(value)
                parse_date attribute: __method__, value: value, allow_empty: true
              end

              # Returns the deposits count as an integer
              def deposits_count
                @deposits_count&.to_i
              end

              # Returns the withdrawals count as an integer
              def withdrawals_count
                @withdrawals_count&.to_i
              end

              # Returns the current balance as an integer
              def current_balance
                @current_balance&.to_i
              end

              # Returns the rule context as an integer
              def rule_context
                @rule_context&.to_i
              end

              protected

              # Sets field values and dependencies for the Create Transaction Request
              def init_field_validations # rubocop:disable Metrics/MethodLength,Metrics/AbcSize
                super

                required_fields.push *%i[
                  transaction_unique_id
                  transaction_created_at
                  customer_ip_address
                ] + customer_information_required_fields + deposit_limits_required_fields

                field_values.merge! transaction_status:      Api::Constants::NonFinancial::Kyc::TransactionStatuses.all,
                                    device_fingerprint_type: [1, 2, 3],
                                    order_source:            GenesisRuby::Api::Constants::NonFinancial::Kyc::OrderSources.all, # rubocop:disable Layout/LineLength
                                    industry_type:           Api::Constants::NonFinancial::Kyc::IndustryTypes.all,
                                    payment_method:          GenesisRuby::Api::Constants::NonFinancial::Kyc::CreateTransactionPaymentMethods.all # rubocop:disable Layout/LineLength

                pm_const = GenesisRuby::Api::Constants::NonFinancial::Kyc::CreateTransactionPaymentMethods
                field_value_dependencies.merge!(
                  {
                    payment_method: {
                      pm_const::PAYMENT_METHOD_CC          => %i[bin tail],
                      pm_const::PAYMENT_METHOD_CC_OPTIONAL => %i[cvv_present hashed_pan],
                      pm_const::PAYMENT_METHOD_EC          => %i[routing account]
                    }
                  }
                )

                field_values.merge! customer_information_required_field_values
              end

              # Returns the request structure for Create Transaction Request
              def request_structure # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
                {
                  session_id:                       session_id,
                  customer_username:                customer_username,
                  customer_unique_id:               customer_unique_id,
                  customer_status:                  customer_status,
                  customer_loyalty_level:           customer_loyalty_level,
                  customer_registration_date:       customer_registration_date,
                  customer_registration_ip_address: customer_registration_ip_address,
                  customer_registration_device_id:  customer_registration_device_id,
                  customer_information:             customer_information_structure,
                  first_deposit_date:               first_deposit_date,
                  first_withdrawal_date:            first_withdrawal_date,
                  deposits_count:                   deposits_count,
                  withdrawals_count:                withdrawals_count,
                  current_balance:                  current_balance,
                  deposit_limits:                   deposit_limits_structure,
                  transaction_unique_id:            transaction_unique_id,
                  billing_information:              kyc_billing_info_structure,
                  shipping_information:             kyc_shipping_info_structure,
                  payment_details:                  payment_details_structure,
                  amount:                           amount,
                  currency:                         currency,
                  transaction_created_at:           transaction_created_at,
                  transaction_status:               transaction_status,
                  customer_ip_address:              customer_ip_address,
                  customer_device_id:               customer_device_id,
                  third_party_device_id:            third_party_device_id,
                  device_fingerprint:               device_fingerprint,
                  device_fingerprint_type:          device_fingerprint_type,
                  shopping_cart_items_count:        shopping_cart_items_count,
                  local_time:                       local_time,
                  order_source:                     order_source,
                  merchant_website:                 merchant_website,
                  industry_type:                    industry_type,
                  customer_password:                customer_password,
                  rule_context:                     rule_context,
                  custom_variable:                  custom_variable
                }
              end

            end
          end
        end
      end
    end
  end
end
