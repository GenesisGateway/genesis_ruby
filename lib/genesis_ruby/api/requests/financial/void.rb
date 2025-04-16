module GenesisRuby
  module Api
    module Requests
      module Financial
        # Void or undo payment transaction request
        class Void < Request

          include Mixins::Requests::Financial::BaseAttributes
          include Mixins::Requests::Financial::ReferenceAttributes

          protected

          # Void transaction type
          def transaction_type
            Api::Constants::Transactions::VOID
          end

          def init_field_validations
            required_fields.push *%i[transaction_id reference_id]
          end

          # Returns the Request transaction structure
          def populate_structure
            @tree_structure = {
              payment_transaction: {
                transaction_type: transaction_type,
                transaction_id:   transaction_id,
                usage:            usage,
                reference_id:     reference_id,
                remote_ip:        remote_ip
              }
            }
          end

        end
      end
    end
  end
end
