# frozen_string_literal: true

module GenesisSpec
  module Stubs
    module Api
      module Requests
        module Financial
          module TravelData
            # Reference Ticket Attributes Stub
            class ReferenceTicketAttributesStub

              include GenesisRuby::Api::Mixins::Requests::RestrictedSetter
              include GenesisRuby::Api::Mixins::Requests::Financial::TravelData::ReferenceTicketAttributes

            end
          end
        end
      end
    end
  end
end
