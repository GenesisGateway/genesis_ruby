# frozen_string_literal: true

module GenesisSpec
  module Stubs
    module Api
      module Requests
        module Financial
          module Cards
            # Account Attributes Stub
            class AccountOwnerAttributesStub

              include GenesisRuby::Api::Mixins::Requests::RestrictedSetter
              include GenesisRuby::Api::Mixins::Requests::Financial::Cards::AccountOwnerAttributes

              public :account_owner_attributes_structure

            end
          end
        end
      end
    end
  end
end
