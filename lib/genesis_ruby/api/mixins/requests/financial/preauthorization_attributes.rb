module GenesisRuby
  module Api
    module Mixins
      module Requests
        module Financial
          # Mixin Preauthorization Attributes
          module PreauthorizationAttributes

            attr_reader :preauthorization

            # Preauthorization setter
            def preauthorization=(value)
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
