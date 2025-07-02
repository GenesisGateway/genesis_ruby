# frozen_string_literal: true

require 'genesis_ruby/utils/options/base'
require 'genesis_ruby/api/constants/transactions/parameters/wpf/reminder_channels'

module GenesisRuby
  module Utils
    module Options
      # Single reminder data object
      class Reminder < Base

        # Min After minutes
        MIN_AFTER = 1
        # Max After minutes
        MAX_AFTER = 31 * 24 * 60

        def []=(key, value)
          unless available_keys.include? key.to_s
            raise InvalidArgumentError, "Invalid Reminder Key given! Allowed: #{available_keys.join(", ")}"
          end

          __send__ "validate_#{key}", value

          super(key.to_sym, value)
        end

        # Single Reinder structure
        def object_structure
          { reminder: self }
        end

        private

        # Available Reminder Data keys
        def available_keys
          %w(channel after)
        end

        # Validate Channel value
        def validate_channel(value)
          return if Api::Constants::Transactions::Parameters::Wpf::ReminderChannels.all.include? value

          raise InvalidArgumentError,
                "Invalid Reminder Channel given. Allowed values: #{
                  Api::Constants::Transactions::Parameters::Wpf::ReminderChannels.all.join(", ")
                }"
        end

        # Number of minutes after WPF creation when the reminder should be sent.
        # Valid value ranges between 1 minute and 31 days given in minutes
        def validate_after(value)
          value_int = value.to_i

          return if value_int >= MIN_AFTER && value_int <= MAX_AFTER

          raise InvalidArgumentError, 'Invalid After value given. Allowed integer between 1 and 31'
        end

      end
    end
  end
end
