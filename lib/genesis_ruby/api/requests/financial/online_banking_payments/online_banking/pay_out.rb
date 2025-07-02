# frozen_string_literal: true

require 'genesis_ruby/api/constants/transactions/parameters/online_banking/bank_account_types'
require 'genesis_ruby/api/constants/transactions/parameters/online_banking/payout_payment_types'

module GenesisRuby
  module Api
    module Requests
      module Financial
        module OnlineBankingPayments
          module OnlineBanking
            # Bank Pay-out option allows merchants to transfer funds directly to their consumers' bank account.
            class PayOut < Base::Financial

              include Api::Mixins::Requests::AddressInfoAttributes
              include Api::Mixins::Requests::BirthDateAttributes
              include Api::Mixins::Requests::DocumentAttributes
              include Api::Mixins::Requests::Financial::AsyncAttributes
              include Api::Mixins::Requests::Financial::NotificationAttributes
              include Api::Mixins::Requests::Financial::OnlineBankingPayments::PayerAttributes
              include Api::Mixins::Requests::Financial::OnlineBankingPayments::PixAttributes

              attr_reader :id_card_number, :payer_bank_phone_number, :document_type, :account_id, :user_id
              attr_accessor :bank_name, :bank_code, :bank_branch, :bank_account_name, :bank_account_number, :pix_key,
                            :bank_province, :bank_account_type, :bank_account_verification_digit, :payment_type

              # Id Card Number
              def id_card_number=(value)
                limited_string attribute: __method__, value: value.to_s.empty? ? nil : value.to_s, max: 30
              end

              # ID card/document type
              def document_type=(value)
                limited_string attribute: __method__, value: value.to_s.empty? ? nil : value.to_s, max: 10
              end

              # Unique account identifier in Trustly's system
              def account_id=(value)
                limited_string attribute: __method__, value: value.to_s.empty? ? nil : value.to_s, max: 255
              end

              # Unique user identifier defined by merchant in their own system
              def user_id=(value)
                limited_string attribute: __method__, value: value.to_s.empty? ? nil : value.to_s, max: 255
              end

              protected

              # Bank Payout transaction type
              def transaction_type
                Api::Constants::Transactions::ONLINE_BANKING_PAYOUT
              end

              # Set field validations
              def init_field_validations
                super

                required_fields.push *%i[transaction_id amount currency notification_url return_success_url
                return_failure_url billing_first_name billing_last_name billing_state billing_country]

                field_values.merge! currency: %w(CNY MYR THB IDR INR ARS BRL CAD CLP COP MXN PEN UYU),
                                    bank_account_type: Constants::Transactions::Parameters::OnlineBanking::
                                        BankAccountTypes.all,
                                    payment_type: Constants::Transactions::Parameters::OnlineBanking::
                                        PayoutPaymentTypes.all
              end

              # Custom validations
              def check_requirements
                validate_brl_currency

                super
              end

              # Bank Payout payment transaction structure
              def payment_transaction_structure # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
                {
                  return_success_url:              return_success_url,
                  return_failure_url:              return_failure_url,
                  notification_url:                notification_url,
                  customer_email:                  customer_email,
                  customer_phone:                  customer_phone,
                  bank_name:                       bank_name,
                  bank_code:                       bank_code,
                  bank_account_name:               bank_account_name,
                  bank_account_number:             bank_account_number,
                  bank_account_type:               bank_account_type,
                  bank_account_verification_digit: bank_account_verification_digit,
                  bank_province:                   bank_province,
                  bank_branch:                     bank_branch,
                  id_card_number:                  id_card_number,
                  payer:                           payer_parameters_structure,
                  document_type:                   document_type,
                  document_id:                     document_id,
                  account_id:                      account_id,
                  user_id:                         user_id,
                  birth_date:                      birth_date,
                  payment_type:                    payment_type,
                  company_type:                    company_type,
                  company_activity:                company_activity,
                  incorporation_date:              incorporation_date,
                  mothers_name:                    mothers_name,
                  pix_key:                         pix_key,
                  billing_address:                 billing_address_parameters_structure,
                  shipping_address:                shipping_address_parameters_structure
                }
              end

              private

              # Specific validations for BRL currency
              def validate_brl_currency
                return unless @currency == 'BRL'
                return if bank_code || bank_name

                raise ParameterError, 'Please verify the following attributes: BRL currency requires one of: ' \
                                         'bank_code and/or bank_name'
              end

            end
          end
        end
      end
    end
  end
end
