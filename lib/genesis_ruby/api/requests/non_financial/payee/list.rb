# frozen_string_literal: true

module GenesisRuby
  module Api
    module Requests
      module NonFinancial
        module Payee
          # Retrieve the details of all Payees.
          class List < Request

            REQUEST_PATH = 'payee'

            def initialize(configuration, _builder_interface = nil)
              super configuration, Builder::JSON
            end

            protected

            # Request configuration
            def init_configuration
              init_json_configuration

              api_config.type = METHOD_GET

              init_api_service_configuration request_path: REQUEST_PATH
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
