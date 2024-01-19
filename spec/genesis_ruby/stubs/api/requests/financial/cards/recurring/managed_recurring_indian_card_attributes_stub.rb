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
                include GenesisRuby::Api::Mixins::Requests::Financial::PaymentAttributes
                include GenesisRuby::Api::Mixins::Requests::Financial::Cards::Recurring::
                    ManagedRecurringIndianCardAttributes

                public :managed_recurring_indian_card_attributes_structure

              end
            end
          end
        end
      end
    end
  end
end
