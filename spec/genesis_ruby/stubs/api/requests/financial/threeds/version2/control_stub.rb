# frozen_string_literal: true

require 'genesis_ruby/api/mixins/requests/financial/threeds/version2/control'

module GenesisSpec
  module Stubs
    module Api
      module Requests
        module Financial
          module Threeds
            module Version2
              class ControlStub

                include GenesisRuby::Api::Mixins::Requests::RestrictedSetter
                include GenesisRuby::Api::Mixins::Requests::Financial::Threeds::Version2::Control

                public :control_attributes, :threeds_control_field_validations

              end
            end
          end
        end
      end
    end
  end
end
