# frozen_string_literal: true

require 'genesis_ruby/api/constants/transactions/parameters/refund/bank_account_types'

module GenesisRuby
  module Api
    module Mixins
      module Requests
        module Financial
          module Refund
            # Customer bank attributes used by the refund transaction requests
            module BankAttributes

              attr_accessor :bank, :bank_branch, :bank_account, :bank_account_type

              protected

              # Customer bank attributes structure
              def refund_bank_attributes_structure
                {
                  bank:              bank,
                  bank_branch:       bank_branch,
                  bank_account:      bank_account,
                  bank_account_type: bank_account_type
                }
              end

              # Allowed values for the customer bank attributes
              def refund_bank_attributes_field_validations
                {
                  bank_account_type: Api::Constants::Transactions::Parameters::Refund::BankAccountTypes.all
                }
              end

            end
          end
        end
      end
    end
  end
end
