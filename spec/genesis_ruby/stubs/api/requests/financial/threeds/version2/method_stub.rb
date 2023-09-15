require 'genesis_ruby/api/mixins/requests/financial/threeds/version2/method'

module GenesisSpec
  module Stubs
    module Api
      module Requests
        module Financial
          module Threeds
            module Version2
              class MethodStub

                include GenesisRuby::Api::Mixins::Requests::Financial::Threeds::Version2::Method

                public :method_attributes

              end
            end
          end
        end
      end
    end
  end
end
