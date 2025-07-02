# frozen_string_literal: true

module GenesisSpec
  module Stubs
    module Api
      module Requests
        module Financial
          module Cards
            module Recurring
              # Managed Recurring Attributes Stub
              class ManagedRecurringAttributesStub

                attr_accessor :currency

                include GenesisRuby::Api::Mixins::Requests::RestrictedSetter
                include GenesisRuby::Api::Mixins::Requests::Financial::Cards::Recurring::ManagedRecurringAttributes

                public :managed_recurring_attributes_structure

              end
            end
          end
        end
      end
    end
  end
end
