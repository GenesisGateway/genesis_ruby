# frozen_string_literal: true

module GenesisRuby
  module Api
    module Constants
      module NonFinancial
        module Alternatives
          module Alipay
            # Alipay Register Merchant allowed merchant types
            class MerchantTypes

              extend Mixins::Constants::Common

              # Sole proprietorship
              INDIVIDUAL = 'INDIVIDUAL'

              # Enterprise (legal entity)
              ENTERPRISE = 'ENTERPRISE'

            end
          end
        end
      end
    end
  end
end
