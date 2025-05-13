module GenesisRuby
  module Api
    module Requests
      module Base
        module NonFinancial
          module Kyc
            # Base Request class for KYC Non-Financial API services
            class Base < Api::Requests::Base::Versioned

              # Constructor for the KYC Base Request
              def initialize(configuration, builder_interface = Builder::JSON)
                super(configuration, builder_interface)
              end

              # Initializes the request path and version
              def init_configuration
                super

                init_kyc_service_configuration request_path: "api/#{version}/#{request_path}"
              end

              # Empty request structure
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
