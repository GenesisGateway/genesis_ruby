# frozen_string_literal: true

require 'genesis_ruby/api/mixins/requests/financial/threeds/version2/purchase'

module GenesisSpec
  module Stubs
    module Api
      module Requests
        module Financial
          module Threeds
            module Version2
              class PurchaseStub

                include GenesisRuby::Api::Mixins::Requests::RestrictedSetter
                include GenesisRuby::Api::Mixins::Requests::Financial::Threeds::Version2::Purchase

                public :purchase_attributes, :threeds_purchase_field_validations

              end
            end
          end
        end
      end
    end
  end
end
