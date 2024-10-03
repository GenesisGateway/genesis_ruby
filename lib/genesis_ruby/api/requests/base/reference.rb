module GenesisRuby
  module Api
    module Requests
      module Base
        # Base class used in the Reference transaction requests
        class Reference < Financial

          include Mixins::Requests::Financial::PaymentAttributes
          include Mixins::Requests::Financial::ReferenceAttributes

          protected

          def init_field_validations
            required_fields.push *%i[transaction_id reference_id amount currency]
            field_values.merge! currency: Api::Constants::Currencies::Iso4217.all.map(&:upcase)
          end

          # Reference transaction request structure
          def reference_transaction_structure
            raise NotImplementedError, 'Reference transaction structure must be implemented.'
          end

          # Payment transaction structure sent to the Gateway
          def payment_transaction_structure
            {
              reference_id: reference_id
            }.merge payment_attributes_structure, reference_transaction_structure
          end

        end
      end
    end
  end
end
