# frozen_string_literal: true

module GenesisRuby
  module Api
    module Requests
      module NonFinancial
        module Fx
          # This call is used to return information about selected Rate for merchant
          class GetRate < Base::Versioned

            include Api::Mixins::Requests::NonFinancial::Fx::IdAttributes
            include Api::Mixins::Requests::NonFinancial::Fx::TierIdAttributes

            # Get Rate initialization
            def initialize(configuration, _builder_interface = nil)
              super configuration

              self.request_path = 'fx/tiers/:tier_id/rates/:id'
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

              required_fields.push *id_required_fields, *tier_id_required_fields
            end

            # Get Rate request structure
            def request_structure
              {}
            end

            # Override API endpoint with provided IDs
            def process_request_parameters
              super

              processed_path = request_path.dup
                                           .gsub(':tier_id', tier_id.to_s)
                                           .gsub(':id', id.to_s)

              init_api_gateway_configuration request_path: "#{version}/#{processed_path}", include_token: false
            end

          end
        end
      end
    end
  end
end
