# frozen_string_literal: true

module GenesisRuby
  module Api
    module Requests
      module Financial
        # Refund reference transaction request
        class Refund < Requests::Base::Reference

          include Mixins::Requests::Financial::Cards::InstallmentAttributes
          include Mixins::Requests::Financial::Refund::BankAttributes
          include Mixins::Requests::Financial::Refund::BeneficiaryAttributes
          include Mixins::Requests::Financial::Refund::TravelTicketAttributes

          include Mixins::Requests::Financial::CommercialCardAttributes

          protected

          # Field Validations
          def init_field_validations
            super

            field_values.merge! refund_bank_attributes_field_validations,
                                refund_travel_ticket_attributes_field_validations
          end

          # Special validations upon document building
          def check_requirements
            super

            validate_commercial_card_attributes
          end

          # Refund Transaction Request type
          def transaction_type
            Api::Constants::Transactions::REFUND
          end

          # Refund Transaction Request Structure
          def reference_transaction_structure
            refund_beneficiary_attributes_structure.merge(
              refund_bank_attributes_structure,
              { installment_plan_id: installment_plan_id, installment_plan_reference: installment_plan_reference },
              refund_travel_ticket_attributes_structure,
              { items: commercial_card_attributes_structure }
            )
          end

        end
      end
    end
  end
end
