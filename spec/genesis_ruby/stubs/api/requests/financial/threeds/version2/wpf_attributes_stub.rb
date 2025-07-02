# frozen_string_literal: true

module GenesisSpec
  module Stubs
    module Api
      module Requests
        module Financial
          module Threeds
            module Version2
              # Wpf Attributes Stub
              class WpfAttributesStub

                include GenesisRuby::Api::Mixins::Requests::Financial::Threeds::Version2::WpfAttributes

                public :threeds_v2_wpf_attributes_structure, :threeds_field_validations

              end
            end
          end
        end
      end
    end
  end
end
