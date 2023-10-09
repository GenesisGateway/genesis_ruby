require 'genesis_ruby/api/requests/base/reference'

module GenesisSpec
  module Stubs
    module Api
      module Requests
        module Base
          class ReferenceStub < GenesisRuby::Api::Requests::Base::Reference

            public :populate_structure

            protected

            def transaction_type
              GenesisRuby::Api::Constants::Transactions::REFUND
            end

            def reference_transaction_structure
              {}
            end

          end
        end
      end
    end
  end
end
