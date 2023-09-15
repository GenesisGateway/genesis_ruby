module GenesisRuby
  module Api
    module Mixins
      module Requests
        module Financial
          # Gaming Attributes mixin
          module GamingAttributes

            attr_reader :gaming

            # Signifies whether a gaming transaction is performed
            def gaming=(value)
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
