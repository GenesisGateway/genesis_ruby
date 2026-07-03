# frozen_string_literal: true

module GenesisRuby
  module Api
    module Requests
      module NonFinancial
        module Payee
          module Owners
            # Retrieve the details of all Owner records.
            class ListOwners < Base::NonFinancial::Payee::Base

              # List Owners initialization
              def initialize(configuration, _builder_interface = nil)
                super configuration

                self.request_path = 'payee/owners'
              end

              protected

              # Override default Versioned Network configuration
              def init_configuration
                super

                init_get_configuration
              end

              # Returns the request structure
              def request_structure
                {}
              end

              # Override API endpoint configuration
              def process_request_parameters
                init_api_service_configuration request_path: request_path, include_token: false

                super
              end

            end
          end
        end
      end
    end
  end
end
