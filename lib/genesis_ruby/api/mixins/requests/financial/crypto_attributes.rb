# frozen_string_literal: true

module GenesisRuby
  module Api
    module Mixins
      module Requests
        module Financial
          # Crypto Attributes mixin
          module CryptoAttributes

            attr_reader :crypto

            # Signifies whether a crypto transaction is performed
            def crypto=(value)
              allowed_options attribute:     __method__,
                              allowed:       [true, false],
                              value:         value,
                              allow_empty:   true,
                              error_message: 'Accepts only boolean values'
            end

          end
        end
      end
    end
  end
end
