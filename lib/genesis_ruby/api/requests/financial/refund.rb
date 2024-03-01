require 'genesis_ruby/api/constants/transactions/parameters/refund/bank_account_types'

module GenesisRuby
  module Api
    module Requests
      module Financial
        # Refund reference transaction request
        class Refund < Requests::Base::Reference

          attr_accessor :beneficiary_bank_code, :beneficiary_name, :beneficiary_account_number, :bank, :bank_branch,
                        :bank_account
          attr_reader :bank_account_type

          # The type of account
          def bank_account_type=(value)
            allowed_options attribute:   __method__,
                            allowed:     Api::Constants::Transactions::Parameters::Refund::BankAccountTypes.all,
                            value:       value,
                            allow_empty: true
          end

          protected

          # Refund Transaction Request type
          def transaction_type
            Api::Constants::Transactions::REFUND
          end

          # Refund Transaction Request Structure
          def reference_transaction_structure
            {
              beneficiary_bank_code:      beneficiary_bank_code,
              beneficiary_name:           beneficiary_name,
              beneficiary_account_number: beneficiary_account_number,
              bank:                       bank,
              bank_branch:                bank_branch,
              bank_account:               bank_account,
              bank_account_type:          bank_account_type
            }
          end

        end
      end
    end
  end
end
