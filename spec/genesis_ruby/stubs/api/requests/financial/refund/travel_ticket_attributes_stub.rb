# frozen_string_literal: true

module GenesisSpec
  module Stubs
    module Api
      module Requests
        module Financial
          module Refund
            # Refund Travel Ticket Attributes Stub
            class TravelTicketAttributesStub

              include GenesisRuby::Api::Mixins::Requests::Financial::Refund::TravelTicketAttributes
              include GenesisRuby::Api::Mixins::Requests::RestrictedSetter

              public :refund_travel_ticket_attributes_structure, :refund_travel_ticket_attributes_field_validations

            end
          end
        end
      end
    end
  end
end
