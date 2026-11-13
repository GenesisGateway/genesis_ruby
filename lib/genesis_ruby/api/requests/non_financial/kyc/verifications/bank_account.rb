# frozen_string_literal: true

require 'genesis_ruby/api/constants/non_financial/kyc/bank_account_types'

module GenesisRuby
  module Api
    module Requests
      module NonFinancial
        module Kyc
          module Verifications
            # Bank Account Verification checks that a bank account, identified by its account number and sort code,
            # belongs to the named holder and whether the declared account type matches the bank's record
            class BankAccount < Api::Requests::Base::NonFinancial::Kyc::Base

              attr_accessor :bank_account_name
              attr_reader   :bank_account_number, :bank_account_type, :sort_code, :reference_id

              # Initializes the Bank Account Verification request
              def initialize(configuration, _builder_interface = nil)
                super configuration

                self.request_path = 'bank_account_verification'
              end

              # The account type related to the account number. Allowed: Business or Personal
              def bank_account_type=(value)
                allowed_options attribute:   __method__,
                                allowed:     Api::Constants::NonFinancial::Kyc::BankAccountTypes.all,
                                value:       value,
                                allow_empty: true
              end

              # The number of the bank account, max 8 characters
              def bank_account_number=(value)
                limited_string attribute: __method__, value: value, max: 8
              end

              # The identifier of the bank for the related account, max 6 characters
              def sort_code=(value)
                limited_string attribute: __method__, value: value, max: 6
              end

              # Unique value to identify the performed verification, max 32 characters
              def reference_id=(value)
                limited_string attribute: __method__, value: value.to_s.empty? ? nil : value, max: 32
              end

              protected

              # Sets the request field validations
              def init_field_validations
                super

                required_fields.push *%i[bank_account_name bank_account_number bank_account_type sort_code]

                field_values.merge! bank_account_type: Api::Constants::NonFinancial::Kyc::BankAccountTypes.all
              end

              # Bank Account Verification request structure
              def request_structure
                {
                  bank_account_name:   bank_account_name,
                  bank_account_number: bank_account_number,
                  bank_account_type:   bank_account_type,
                  sort_code:           sort_code,
                  reference_id:        reference_id
                }
              end

            end
          end
        end
      end
    end
  end
end
