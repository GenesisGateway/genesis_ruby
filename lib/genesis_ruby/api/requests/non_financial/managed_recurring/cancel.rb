# frozen_string_literal: true

module GenesisRuby
  module Api
    module Requests
      module NonFinancial
        module ManagedRecurring
          # Cancels an active managed recurring item by its unique identifier.
          class Cancel < Base::Versioned

            attr_writer :unique_id

            # Cancel initialization
            def initialize(configuration, _builder_interface = nil)
              super configuration

              self.request_path = 'managed_recurring/items/:unique_id'
            end

            # Unique identifier of the managed recurring item
            def unique_id
              @unique_id.to_s
            end

            protected

            # Override default Versioned Network configuration
            def init_configuration
              super

              init_delete_configuration
            end

            # Cancel request field validations
            def init_field_validations
              super

              required_fields.push *%i[unique_id]
            end

            # Cancel request structure
            def request_structure
              {}
            end

            # Override API endpoint with provided Unique ID
            def process_request_parameters
              super

              processed_path = request_path.gsub(':unique_id', unique_id.to_s)

              init_api_gateway_configuration(
                request_path:  "#{version}/#{processed_path}",
                include_token: false
              )
            end

          end
        end
      end
    end
  end
end
