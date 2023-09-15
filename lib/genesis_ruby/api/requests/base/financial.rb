module GenesisRuby
  module Api
    module Requests
      module Base
        # Base class used by all Financial transaction requests
        class Financial < Request

          include Mixins::Requests::Financial::BaseAttributes

          protected

          # Returns the Request transaction type
          def transaction_type
            raise NotImplementedError, 'Transaction Type method must be implemented'
          end

          # Return additional request attributes
          def payment_transaction_structure
            raise NotImplementedError, 'Payment Transaction Structure method must be implemented'
          end

          # Request Configuration
          def init_configuration
            super
            init_xml_configuration
            init_api_gateway_configuration
          end

          def populate_structure
            self.tree_structure = {
              payment_transaction: {
                transaction_type: transaction_type,
                transaction_id:   transaction_id,
                usage:            usage,
                remote_ip:        remote_ip
              }.merge(payment_transaction_structure)
            }
          end

        end
      end
    end
  end
end
