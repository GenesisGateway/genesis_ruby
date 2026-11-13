# frozen_string_literal: true

require 'genesis_ruby/api/mixins/requests/financial/threeds/force_threeds_attributes'

module GenesisSpec
  module Stubs
    module Api
      module Requests
        module Financial
          module Threeds
            class ForceThreedsAttributesStub

              include GenesisRuby::Api::Mixins::Requests::RestrictedSetter
              include GenesisRuby::Api::Mixins::Requests::Financial::Threeds::ForceThreedsAttributes

            end
          end
        end
      end
    end
  end
end
