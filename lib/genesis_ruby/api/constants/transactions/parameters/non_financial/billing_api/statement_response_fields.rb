# frozen_string_literal: true

module GenesisRuby
  module Api
    module Constants
      module Transactions
        module Parameters
          module NonFinancial
            module BillingApi
              # Billing API Statement Response Fields allowed values
              class StatementResponseFields

                extend Mixins::Constants::Common

                ID                     = 'id'
                BILLING_STATEMENT      = 'billingStatement'
                STATUS                 = 'status'
                COMPANY                = 'company'
                MASTER_ACCOUNT_NAME    = 'masterAccountName'
                MASTER_ACCOUNT_CURRENCY = 'masterAccountCurrency'
                VALUE_DATE             = 'valueDate'
                CREATION_DATE          = 'creationDate'
                CURRENCY               = 'currency'
                PAYMENT_METHOD         = 'paymentMethod'
                START_DATE             = 'startDate'
                END_DATE               = 'endDate'
                SUMMARY                = 'summary'
                DETAILS                = 'details'

              end
            end
          end
        end
      end
    end
  end
end
