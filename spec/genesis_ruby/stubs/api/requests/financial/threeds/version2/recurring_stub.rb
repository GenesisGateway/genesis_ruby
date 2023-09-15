require 'genesis_ruby/api/mixins/requests/financial/threeds/version2/recurring'

module GenesisSpec
  module Stubs
    module Api
      module Requests
        module Financial
          module Threeds
            module Version2
              class RecurringStub

                include GenesisRuby::Api::Mixins::Requests::RestrictedSetter
                include GenesisRuby::Api::Mixins::Requests::Financial::Threeds::Version2::Recurring

                public :recurring_attributes

              end
            end
          end
        end
      end
    end
  end
end
