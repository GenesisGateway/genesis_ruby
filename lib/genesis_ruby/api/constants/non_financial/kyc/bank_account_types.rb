# frozen_string_literal: true

module GenesisRuby
  module Api
    module Constants
      module NonFinancial
        module Kyc
          # Bank Account Verification allowed bank account types
          class BankAccountTypes

            extend Mixins::Constants::Common

            # Business bank account
            BUSINESS = 'Business'

            # Personal bank account
            PERSONAL = 'Personal'

          end
        end
      end
    end
  end
end
