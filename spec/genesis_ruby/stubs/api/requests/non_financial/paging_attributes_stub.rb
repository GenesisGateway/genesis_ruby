module GenesisSpec
  module Stubs
    module Api
      module Requests
        module NonFinancial
          # Paging Attributes stub
          class PagingAttributesStub

            include GenesisRuby::Api::Mixins::Requests::NonFinancial::PagingAttributes
            include GenesisRuby::Api::Mixins::Requests::RestrictedSetter

          end
        end
      end
    end
  end
end
