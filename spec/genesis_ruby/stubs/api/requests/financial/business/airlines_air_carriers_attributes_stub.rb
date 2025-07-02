# frozen_string_literal: true

module GenesisSpec
  module Stubs
    module Api
      module Requests
        module Financial
          module Business
            # Airlines Air Carriers Attributes Stub
            class AirlinesAirCarriersAttributesStub

              include GenesisRuby::Api::Mixins::Requests::RestrictedSetter
              include GenesisRuby::Api::Mixins::Requests::Financial::Business::AirlinesAirCarriersAttributes

              public :airlines_air_carriers_attributes_structure

            end
          end
        end
      end
    end
  end
end
