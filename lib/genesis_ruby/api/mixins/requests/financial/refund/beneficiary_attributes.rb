# frozen_string_literal: true

module GenesisRuby
  module Api
    module Mixins
      module Requests
        module Financial
          module Refund
            # Beneficiary bank account attributes used by the refund transaction requests
            module BeneficiaryAttributes

              attr_accessor :beneficiary_bank_code, :beneficiary_name, :beneficiary_account_number

              protected

              # Beneficiary bank account attributes structure (flat, no nested beneficiary node)
              def refund_beneficiary_attributes_structure
                {
                  beneficiary_bank_code:      beneficiary_bank_code,
                  beneficiary_name:           beneficiary_name,
                  beneficiary_account_number: beneficiary_account_number
                }
              end

            end
          end
        end
      end
    end
  end
end
