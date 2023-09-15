require 'genesis_ruby/utils/common'

module GenesisRuby
  module Api
    module Mixins
      module Constants
        # Common method between all Constant classes
        # use extend to add methods below to a specific module
        module Common

          # Get all defined constant values
          def all
            GenesisRuby::Utils::Common.constant_values(self)
          end

          # Validate given value against all available constant values
          def valid?(value, strict: false)
            value = value.downcase if !strict && value.is_a?(String)

            all.include?(value)
          end

        end
      end
    end
  end
end
