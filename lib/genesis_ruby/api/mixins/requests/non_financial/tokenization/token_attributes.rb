module GenesisRuby
  module Api
    module Mixins
      module Requests
        module NonFinancial
          module Tokenization
            # Token Attributes mixin
            module TokenAttributes

              attr_reader :token

              # Plain-text token value
              def token=(value)
                limited_string attribute: __method__, value: value.to_s.empty? ? nil : value.to_s, max: 36
              end

            end
          end
        end
      end
    end
  end
end
