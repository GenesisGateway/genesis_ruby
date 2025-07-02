# frozen_string_literal: true

module GenesisRuby
  module Api
    module Requests
      module NonFinancial
        module Fraud
          module Retrieval
            # Retrieve a single retrieval request or a list of requests by ARN or by passing the unique ID
            # of the original transaction.
            class Transaction < Api::Request

              include Api::Mixins::Requests::NonFinancial::ModeAttributes

              attr_accessor :arn, :original_transaction_unique_id

              protected

              # Set Gateway API configuration
              def init_configuration
                init_xml_configuration
                init_api_gateway_configuration request_path: 'retrieval_requests', include_token: false
              end

              # Retrieval custom field validations
              def check_requirements
                unless arn.nil? ^ original_transaction_unique_id.nil?
                  raise(
                    ParameterError,
                    'Either arn or original_transaction_unique_id field has to be set, not both.'
                  )
                end

                super
              end

              # API Request structure
              def populate_structure
                @tree_structure = {
                  retrieval_request_request: {
                    arn:                            arn,
                    original_transaction_unique_id: original_transaction_unique_id,
                    mode:                           mode
                  }
                }
              end

            end
          end
        end
      end
    end
  end
end
