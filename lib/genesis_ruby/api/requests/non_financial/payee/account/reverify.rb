# frozen_string_literal: true

module GenesisRuby
  module Api
    module Requests
      module NonFinancial
        module Payee
          module Account
            # Reverify a specific Account that belongs to a specific Payee.
            class Reverify < Request

              REQUEST_PATH = 'payee/:payee_unique_id/account/:account_unique_id/reverify'

              attr_accessor :payee_unique_id, :account_unique_id

              # Reverify Payee Account initialization
              def initialize(configuration, _builder_interface = nil)
                super configuration, Builder::JSON
              end

              protected

              # Sets the request field validations
              def init_field_validations
                super

                required_fields.push *%i[
                  payee_unique_id account_unique_id
                ]
              end

              # Request configuration
              def init_configuration
                init_json_configuration

                api_config.type = METHOD_POST
              end

              # Override API endpoint configuration
              def process_request_parameters
                processed_path = REQUEST_PATH.dup
                                             .gsub(':payee_unique_id', payee_unique_id.to_s)
                                             .gsub(':account_unique_id', account_unique_id.to_s)

                init_api_service_configuration request_path: processed_path

                super
              end

              # Request structure
              def populate_structure
                @tree_structure = {}
              end

            end
          end
        end
      end
    end
  end
end
