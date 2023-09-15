require 'genesis_ruby/api/requests/base/financial'

module GenesisSpec
  module Stubs
    module Api
      module Requests
        module Base
          # Financial stub
          class FinancialStub < GenesisRuby::Api::Requests::Base::Financial

            public :populate_structure

            protected

            def transaction_type
              GenesisRuby::Api::Constants::Transactions::SALE
            end

            def payment_transaction_structure
              {}
            end

          end
        end
      end
    end
  end
end
