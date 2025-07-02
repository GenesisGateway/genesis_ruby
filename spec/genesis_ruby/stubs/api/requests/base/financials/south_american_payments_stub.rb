# frozen_string_literal: true

module GenesisSpec
  module Stubs
    module Api
      module Requests
        module Base
          module Financials
            # South American Payments Stub
            class SouthAmericanPaymentsStub < GenesisRuby::Api::Requests::Base::Financials::SouthAmericanPayments

              protected

              def transaction_type
                'south_american_payment_stub'
              end

              def allowed_billing_countries
                %w(BR)
              end

            end
          end
        end
      end
    end
  end
end
