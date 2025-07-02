# frozen_string_literal: true

module GenesisRuby
  module Api
    module Requests
      module NonFinancial
        module Installments
          # Retrieves details about a specific installment based on its ID.
          class Show < Base::Versioned

            attr_writer :installment_id

            # Installments Show initialization
            def initialize(configuration, _builder_interface = nil)
              super configuration

              self.request_path = 'installments/:installment_id'
            end

            # Installment identifier
            def installment_id
              @installment_id.to_s
            end

            protected

            # Override default Versioned Network configuration
            def init_configuration
              super

              init_get_configuration
            end

            # Fetch request field validations
            def init_field_validations
              super

              required_fields.push *%i[installment_id]
            end

            # Installments Show request structure
            def request_structure
              {}
            end

            # Override API endpoint with provided Installment ID
            def process_request_parameters
              super

              processed_path = request_path.gsub(':installment_id', installment_id.to_s)

              init_api_gateway_configuration(
                request_path: "#{version}/#{processed_path}",
                include_token: false
              )
            end

          end
        end
      end
    end
  end
end
