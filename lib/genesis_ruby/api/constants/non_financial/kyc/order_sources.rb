# frozen_string_literal: true

module GenesisRuby
  module Api
    module Constants
      module NonFinancial
        module Kyc
          # OrderSources helper class
          class OrderSources

            extend Mixins::Constants::Common

            ORDER_SOURCE_INTERNET = 'internet'
            ORDER_SOURCE_MOBILE   = 'mobile'
            ORDER_SOURCE_INHOUSE  = 'inhouse'

          end
        end
      end
    end
  end
end
