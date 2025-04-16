module GenesisRuby
  module Api
    module Requests
      module NonFinancial
        module ProcessedTransactions
          # Single processed transaction retrieval allows to get a certain processed transaction by
          # its ARN or by passing its unique ID.
          class Transaction < Request

            attr_accessor :arn, :unique_id

            protected

            # Processed Transactions API Transaction request configuration
            def init_configuration
              init_xml_configuration

              init_api_gateway_configuration request_path: 'processed_transactions', include_token: false
            end

            # Processed Transactions API Transaction custom validations
            def check_requirements
              unless arn.nil? ^ unique_id.nil?
                raise(
                  ParameterError,
                  'Either ARN or unique ID field has to be set, not both'
                )
              end

              super
            end

            # Processed Transactions API Transaction request structure
            def populate_structure
              @tree_structure = {
                processed_transaction_request: {
                  arn:       arn,
                  unique_id: unique_id
                }
              }
            end

          end
        end
      end
    end
  end
end
