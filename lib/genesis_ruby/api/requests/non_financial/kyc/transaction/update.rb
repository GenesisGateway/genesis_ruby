# frozen_string_literal: true

require 'genesis_ruby/api/constants/non_financial/kyc/transaction_statuses'

module GenesisRuby
  module Api
    module Requests
      module NonFinancial
        module Kyc
          module Transaction
            # Utilize this method to update a particular transaction status so we can continue improving the data models
            # and provide the best scores and recommendations.
            class Update < Api::Requests::Base::NonFinancial::Kyc::Base

              attr_accessor :session_id,
                            :transaction_unique_id,
                            :reason,
                            :reference_id,
                            :cvv_check_result,
                            :avs_check_result,
                            :processor_identifier
              attr_writer   :transaction_status

              # Initialize the Update transaction request
              def initialize(configuration, _builder_interface = nil)
                super configuration

                self.request_path = 'update_transaction'
              end

              # Returns the transaction status as an integer
              def transaction_status
                @transaction_status&.to_i
              end

              # Initializes the required fields and their validations
              def init_field_validations
                required_fields.push *%i[transaction_unique_id]

                field_values.merge! transaction_status: Api::Constants::NonFinancial::Kyc::TransactionStatuses.all
              end

              # Returns the request structure for the Update transaction request
              def request_structure
                {
                  session_id:            session_id,
                  transaction_unique_id: transaction_unique_id,
                  reference_id:          reference_id,
                  transaction_status:    transaction_status,
                  reason:                reason,
                  cvv_check_result:      cvv_check_result,
                  avs_check_result:      avs_check_result,
                  processor_identifier:  processor_identifier
                }
              end

            end
          end
        end
      end
    end
  end
end
