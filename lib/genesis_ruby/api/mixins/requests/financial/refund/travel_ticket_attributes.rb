# frozen_string_literal: true

require 'genesis_ruby/api/constants/transactions/parameters/refund/credit_reason_indicators'
require 'genesis_ruby/api/constants/transactions/parameters/refund/ticket_change_indicators'

# rubocop:disable Naming/VariableNumber
module GenesisRuby
  module Api
    module Mixins
      module Requests
        module Financial
          module Refund
            # Travel Level 3 ticket indicators used by the refund transaction requests
            module TravelTicketAttributes

              attr_accessor :credit_reason_indicator_1, :credit_reason_indicator_2, :ticket_change_indicator

              protected

              # Travel ticket indicators structure, serialised under travel / ticket
              def refund_travel_ticket_attributes_structure
                {
                  travel: {
                    ticket: {
                      credit_reason_indicator_1: credit_reason_indicator_1,
                      credit_reason_indicator_2: credit_reason_indicator_2,
                      ticket_change_indicator:   ticket_change_indicator
                    }
                  }
                }
              end

              # Allowed values for the travel ticket indicators
              def refund_travel_ticket_attributes_field_validations
                credit_reasons = Api::Constants::Transactions::Parameters::Refund::CreditReasonIndicators.all
                ticket_changes = Api::Constants::Transactions::Parameters::Refund::TicketChangeIndicators.all

                {
                  credit_reason_indicator_1: credit_reasons,
                  credit_reason_indicator_2: credit_reasons,
                  ticket_change_indicator:   ticket_changes
                }
              end

            end
          end
        end
      end
    end
  end
end
# rubocop:enable Naming/VariableNumber
