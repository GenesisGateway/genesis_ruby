# frozen_string_literal: true

module GenesisRuby
  module Api
    module Mixins
      module Requests
        module Financial
          module Cards
            # Tokenization Params Attributes mixin
            module TokenizationParamsAttributes

              attr_accessor :tokenization_tavv
              attr_reader :tokenization_eci

              # Electronic Commerce Indicator (ECI) is a value that is returned from the Directory Server
              # (Visa, MasterCard, etc.) to indicate the authentication results of your customer’s
              # credit card payment on 3D Secure
              def tokenization_eci=(value)
                limited_string attribute: __method__, value: value.to_s.empty? ? nil : value.to_s, max: 2
              end

              protected

              # Tokenization Params Attributes Structure
              def tokenization_params_attributes_structure
                {
                  eci:  tokenization_eci,
                  tavv: tokenization_tavv
                }
              end

            end
          end
        end
      end
    end
  end
end
