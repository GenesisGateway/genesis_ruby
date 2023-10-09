module GenesisRuby
  module Api
    module Requests
      module NonFinancial
        module Reconcile
          # Reconcile can be used to retrieve data about a transaction.
          # This can be useful if you want to retrieve information about a transaction whose status is timeout,
          # which returned an error or has changed eg. has beed chargebacked.
          class Transaction < Api::Request

            attr_accessor :arn, :transaction_id, :unique_id

            protected

            # Set Gateway API configuration
            def init_configuration
              init_xml_configuration
              init_api_gateway_configuration request_path: 'reconcile'
            end

            # API Request structure
            def populate_structure
              @tree_structure = {
                reconcile: {
                  arn:            arn,
                  transaction_id: transaction_id,
                  unique_id:      unique_id
                }
              }
            end

          end
        end
      end
    end
  end
end
