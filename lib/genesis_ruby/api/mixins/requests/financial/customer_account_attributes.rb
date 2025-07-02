# frozen_string_literal: true

module GenesisRuby
  module Api
    module Mixins
      module Requests
        module Financial
          # Customer Account Attributes
          module CustomerAccountAttributes

            attr_reader :customer_account_id

            # Customer account id parameter validation
            def customer_account_id=(value)
              limited_string attribute: __method__, value: value.to_s.empty? ? nil : value.to_s, max: 20
            end

          end
        end
      end
    end
  end
end
