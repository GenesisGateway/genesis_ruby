module GenesisRuby
  module Api
    module Requests
      module NonFinancial
        module Fx
          # This call is used to return all Tiers that are related to your account
          class GetTiers < Base::Versioned

            # Get Tiers initialization
            def initialize(configuration, _builder_interface = nil)
              super configuration

              self.request_path = 'fx/tiers'
            end

            protected

            # Override default Versioned Network configuration
            def init_configuration
              super

              init_get_configuration
            end

            # Get Tiers request structure
            def request_structure
              {}
            end

          end
        end
      end
    end
  end
end
