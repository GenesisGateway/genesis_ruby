# frozen_string_literal: true

module GenesisRuby
  module Api
    module Requests
      module Base
        module NonFinancial
          module Payee
            # Base Request class for Payee Non-Financial API services (non-versioned)
            class Base < Api::Request

              protected

              attr_reader :request_path

              # Constructor for the Payee Base Request
              def initialize(configuration, _builder_interface = nil)
                super configuration, Builder::JSON
              end

              # Defines the endpoint of the request
              def request_path=(value)
                @request_path = value.to_s

                init_configuration
              end

              # Initialize Request configuration
              def init_configuration
                super

                init_json_configuration
                init_api_service_configuration request_path: request_path if request_path && !request_path.empty?
              end

              # Request structure. Overridden for common structure parameters
              def populate_structure
                super

                @tree_structure = request_structure
              end

              # Request structure
              def request_structure
                {}
              end

            end
          end
        end
      end
    end
  end
end
