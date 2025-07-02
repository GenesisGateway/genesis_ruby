# frozen_string_literal: true

module GenesisRuby
  module Api
    module Mixins
      module Requests
        module Financial
          # Mixin Notification Attributes
          module NotificationAttributes

            attr_reader :notification_url

            # Return Success URL setter
            def notification_url=(value)
              unless GenesisRuby::Utils::Common.valid_url?(value)
                raise ParameterError, "Invalid URL given for #{__method__}"
              end

              @notification_url = value
            end

          end
        end
      end
    end
  end
end
