module GenesisRuby
  module Api
    module Requests
      module Financial
        # Capture settles a transaction which has been authorized before
        class Capture < Requests::Base::Reference

          include Mixins::Requests::Financial::Business::BusinessAttributes
          include Mixins::Requests::Financial::Cards::InstallmentAttributes
          include Mixins::Requests::Financial::TravelData::TravelAttributes

          protected

          # Capture Transaction Request type
          def transaction_type
            Api::Constants::Transactions::CAPTURE
          end

          # Capture Transaction Request Structure
          def reference_transaction_structure
            {
              reference_id:               reference_id,
              business_attributes:        business_attributes_structure,
              travel:                     travel_data_attributes_structure,
              installment_plan_id:        installment_plan_id,
              installment_plan_reference: installment_plan_reference
            }
          end

        end
      end
    end
  end
end
