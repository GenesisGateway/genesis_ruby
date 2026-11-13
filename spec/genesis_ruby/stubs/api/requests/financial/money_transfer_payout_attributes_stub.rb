# frozen_string_literal: true

module GenesisSpec
  module Stubs
    module Api
      module Requests
        module Financial
          # Money Transfer Payout Attributes Stub
          class MoneyTransferPayoutAttributesStub

            include GenesisRuby::Api::Mixins::Requests::Financial::MoneyTransferPayoutAttributes
            include GenesisRuby::Api::Mixins::Requests::RestrictedSetter

            public :money_transfer_payout_attributes_structure

          end
        end
      end
    end
  end
end
