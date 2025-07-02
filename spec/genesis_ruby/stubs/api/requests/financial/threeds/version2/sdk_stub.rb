# frozen_string_literal: true

require 'genesis_ruby/api/mixins/requests/financial/threeds/version2/sdk'

module GenesisSpec
  module Stubs
    module Api
      module Requests
        module Financial
          module Threeds
            module Version2
              class SdkStub

                include GenesisRuby::Api::Mixins::Requests::RestrictedSetter
                include GenesisRuby::Api::Mixins::Requests::Financial::Threeds::Version2::Sdk

                public :sdk_attributes, :threeds_sdk_field_validations

              end
            end
          end
        end
      end
    end
  end
end
