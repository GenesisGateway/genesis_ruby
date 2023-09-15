module GenesisRuby
  module Api
    module Mixins
      module Requests
        module Financial
          # Mixin Pending Payment Attributes
          module PendingPaymentAttributes

            attr_reader :return_pending_url

            # Return Success URL setter
            def return_pending_url=(value)
              unless GenesisRuby::Utils::Common.valid_url?(value)
                raise ParameterError, "Invalid URL given for #{__method__}"
              end

              @return_pending_url = value
            end

          end
        end
      end
    end
  end
end
