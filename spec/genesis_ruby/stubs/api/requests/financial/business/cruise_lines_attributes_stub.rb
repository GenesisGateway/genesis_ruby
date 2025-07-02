# frozen_string_literal: true

module GenesisSpec
  module Stubs
    module Api
      module Requests
        module Financial
          module Business
            # Cruise Lines Attributes Stub
            class CruiseLinesAttributesStub

              include GenesisRuby::Api::Mixins::Requests::RestrictedSetter
              include GenesisRuby::Api::Mixins::Requests::Financial::Business::CruiseLinesAttributes

              public :cruise_lines_attributes_structure

            end
          end
        end
      end
    end
  end
end
