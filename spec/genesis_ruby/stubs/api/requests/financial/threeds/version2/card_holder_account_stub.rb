# frozen_string_literal: true

module GenesisSpec
  module Stubs
    module Api
      module Requests
        module Financial
          module Threeds
            module Version2
              class CardHolderAccountStub

                include GenesisRuby::Api::Mixins::Requests::RestrictedSetter
                include GenesisRuby::Api::Mixins::Requests::Financial::Threeds::Version2::CardHolderAccount

                public :card_holder_account_attributes, :threeds_card_holder_field_validations

              end
            end
          end
        end
      end
    end
  end
end
