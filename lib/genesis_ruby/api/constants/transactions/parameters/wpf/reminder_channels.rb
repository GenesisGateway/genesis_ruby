module GenesisRuby
  module Api
    module Constants
      module Transactions
        module Parameters
          module Wpf
            # Channel for sending WPF reminder. Valid values are ’email’ and ’sms’
            class ReminderChannels

              extend Mixins::Constants::Common

              # Channel email
              EMAIL = 'email'.freeze

              # Channel sms
              SMS   = 'sms'.freeze

            end
          end
        end
      end
    end
  end
end
