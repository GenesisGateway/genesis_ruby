# frozen_string_literal: true

module GenesisSpec
  module Stubs
    module Api
      module Requests
        module Financial
          module Cards
            module Recurring
              # Managed Recurring Indian Card Attributes Stub
              class ManagedRecurringIndianCardAttributesStub

                include GenesisRuby::Api::Mixins::Requests::RestrictedSetter
                include GenesisRuby::Api::Mixins::Requests::Financial::Cards::Recurring::
                    ManagedRecurringIndianCardAttributes

                attr_accessor :currency

                public :managed_recurring_indian_card_attributes_structure

              end
            end
          end
        end
      end
    end
  end
end
