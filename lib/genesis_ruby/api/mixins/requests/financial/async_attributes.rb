# frozen_string_literal: true

module GenesisRuby
  module Api
    module Mixins
      module Requests
        module Financial
          # Mixin Async Attributes
          module AsyncAttributes

            attr_reader :return_success_url, :return_failure_url

            # Return Success URL setter
            def return_success_url=(value)
              unless GenesisRuby::Utils::Common.valid_url?(value)
                raise ParameterError, "Invalid URL given for #{__method__}"
              end

              @return_success_url = value
            end

            # Return Failure URL setter
            def return_failure_url=(value)
              unless GenesisRuby::Utils::Common.valid_url?(value)
                raise ParameterError, "Invalid URL given for #{__method__}"
              end

              @return_failure_url = value
            end

          end
        end
      end
    end
  end
end
