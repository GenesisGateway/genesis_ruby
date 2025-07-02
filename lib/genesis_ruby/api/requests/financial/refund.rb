# frozen_string_literal: true

require 'genesis_ruby/api/constants/transactions/parameters/refund/bank_account_types'
require 'genesis_ruby/api/constants/transactions/parameters/refund/credit_reason_indicators'
require 'genesis_ruby/api/constants/transactions/parameters/refund/ticket_change_indicators'

# rubocop:disable Naming/VariableNumber
module GenesisRuby
  module Api
    module Requests
      module Financial
        # Refund reference transaction request
        class Refund < Requests::Base::Reference

          include Mixins::Requests::Financial::Cards::InstallmentAttributes

          attr_accessor :beneficiary_bank_code, :beneficiary_name, :beneficiary_account_number, :bank, :bank_branch,
                        :bank_account, :bank_account_type, :credit_reason_indicator_1, :credit_reason_indicator_2,
                        :ticket_change_indicator

          protected

          # Field Validations
          def init_field_validations
            super

            field_values.merge! bank_account_type: Constants::Transactions::Parameters::Refund::BankAccountTypes.all,
                                credit_reason_indicator_1: Constants::Transactions::Parameters::Refund::
                                    CreditReasonIndicators.all,
                                credit_reason_indicator_2: Constants::Transactions::Parameters::Refund::
                                    CreditReasonIndicators.all,
                                ticket_change_indicator:   Constants::Transactions::Parameters::Refund::
                                    TicketChangeIndicators.all
          end

          # Refund Transaction Request type
          def transaction_type
            Api::Constants::Transactions::REFUND
          end

          # Refund Transaction Request Structure
          def reference_transaction_structure # rubocop:disable Metrics/MethodLength
            {
              beneficiary_bank_code:      beneficiary_bank_code,
              beneficiary_name:           beneficiary_name,
              beneficiary_account_number: beneficiary_account_number,
              bank:                       bank,
              bank_branch:                bank_branch,
              bank_account:               bank_account,
              bank_account_type:          bank_account_type,
              installment_plan_id:        installment_plan_id,
              installment_plan_reference: installment_plan_reference,
              travel:                     {
                ticket: {
                  credit_reason_indicator_1: credit_reason_indicator_1,
                  credit_reason_indicator_2: credit_reason_indicator_2,
                  ticket_change_indicator:   ticket_change_indicator
                }
              }
            }
          end

        end
      end
    end
  end
end
# rubocop:enable Naming/VariableNumber
