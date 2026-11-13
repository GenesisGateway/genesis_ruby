# frozen_string_literal: true

module GenesisRuby
  module Api
    module Constants
      module Transactions
        module Parameters
          module NonFinancial
            module BillingApi
              # Billing API Statement Order By Field allowed values
              class StatementOrderByFields

                extend Mixins::Constants::Common

                BILLING_STATEMENT   = 'billingStatement'
                CREATION_DATE       = 'creationDate'
                START_DATE          = 'startDate'
                END_DATE            = 'endDate'
                VALUE_DATE          = 'valueDate'
                CURRENCY            = 'currency'
                STATUS              = 'status'
                MASTER_ACCOUNT_NAME = 'masterAccountName'

              end
            end
          end
        end
      end
    end
  end
end
