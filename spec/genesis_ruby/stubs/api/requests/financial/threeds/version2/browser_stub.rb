require 'genesis_ruby/api/mixins/requests/financial/threeds/version2/browser'

module GenesisSpec
  module Stubs
    module Api
      module Requests
        module Financial
          module Threeds
            module Version2
              class BrowserStub

                include GenesisRuby::Api::Mixins::Requests::RestrictedSetter
                include GenesisRuby::Api::Mixins::Requests::Financial::Threeds::Version2::Browser

                public :browser_attributes, :threeds_browser_field_validations

              end
            end
          end
        end
      end
    end
  end
end
