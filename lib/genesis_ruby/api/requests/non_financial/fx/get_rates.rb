module GenesisRuby
  module Api
    module Requests
      module NonFinancial
        module Fx
          # This call is used to return all rates for Tier
          class GetRates < Base::Versioned

            include Api::Mixins::Requests::NonFinancial::Fx::TierIdAttributes

            # Get Rates initialization
            def initialize(configuration, _builder_interface = nil)
              super configuration

              self.request_path = 'fx/tiers/:tier_id/rates'
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

              required_fields.push *tier_id_required_fields
            end

            # Get Rates request structure
            def request_structure
              {}
            end

            # Override API endpoint with provided ID
            def process_request_parameters
              super

              request_path.sub!(':tier_id', tier_id)

              init_api_gateway_configuration request_path: "#{version}/#{request_path}", include_token: false
            end

          end
        end
      end
    end
  end
end
