# frozen_string_literal: true

module GenesisRuby
  module Api
    module Requests
      module Financial
        # Async Refund reference transaction request. Returns already billed amounts through an asynchronous workflow
        class AsyncRefund < Requests::Base::Reference

          include Mixins::Requests::Financial::Refund::BankAttributes
          include Mixins::Requests::Financial::Refund::BeneficiaryAttributes
          include Mixins::Requests::Financial::Refund::TravelTicketAttributes

          protected

          # Async Refund field validations
          def init_field_validations
            super

            field_values.merge! refund_bank_attributes_field_validations,
                                refund_travel_ticket_attributes_field_validations
          end

          # Async Refund transaction type
          def transaction_type
            Api::Constants::Transactions::ASYNC_REFUND
          end

          # Async Refund request structure
          def reference_transaction_structure
            refund_beneficiary_attributes_structure.merge(
              refund_bank_attributes_structure,
              refund_travel_ticket_attributes_structure
            )
          end

        end
      end
    end
  end
end
