# frozen_string_literal: true

module GenesisRuby
  module Api
    module Mixins
      module Requests
        module Financial
          # Moto Attributes mixin
          module MotoAttributes

            attr_reader :moto

            # Signifies whether a moto transaction is performed
            def moto=(value)
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
