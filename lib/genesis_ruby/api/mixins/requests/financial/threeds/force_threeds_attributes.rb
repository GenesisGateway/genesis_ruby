# frozen_string_literal: true

module GenesisRuby
  module Api
    module Mixins
      module Requests
        module Financial
          module Threeds
            # Force 3DS attributes mixin
            module ForceThreedsAttributes

              attr_reader :force_threeds

              # Force 3DSv2 authentication when no 3DSv2 parameters are sent
              def force_threeds=(value)
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
end
