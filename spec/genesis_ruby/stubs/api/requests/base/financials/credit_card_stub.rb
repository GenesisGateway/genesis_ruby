require 'genesis_ruby/api/requests/base/financials/credit_card'

module GenesisSpec
  module Stubs
    module Api
      module Requests
        module Base
          module Financials
            # Credit Card stub
            class CreditCardStub < GenesisRuby::Api::Requests::Base::Financials::CreditCard

              protected

              def transaction_type
                GenesisRuby::Api::Constants::Transactions::SALE
              end

            end
          end
        end
      end
    end
  end
end
