module GenesisRuby
  module Api
    module Requests
      module NonFinancial
        module Fx
          # This call is used to return information about selected Rate by currency pair
          class SearchRate < Base::Versioned

            include Api::Mixins::Requests::NonFinancial::Fx::TierIdAttributes

            attr_writer :source_currency, :target_currency

            # Search Rate initialization
            def initialize(configuration, _builder_interface = nil)
              super configuration

              self.request_path = 'fx/tiers/:tier_id/rates/search'
            end

            # Source currency
            def source_currency
              @source_currency.to_s.upcase
            end

            # Target currency
            def target_currency
              @target_currency.to_s.upcase
            end

            protected

            # Fetch request field validations
            def init_field_validations
              super

              required_fields.push *tier_id_required_fields, *%i[source_currency target_currency]
            end

            # Search Rate request structure
            def request_structure
              {
                source_currency: source_currency,
                target_currency: target_currency
              }
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
