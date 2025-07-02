# frozen_string_literal: true

require 'genesis_ruby/utils/options/reminder'

module GenesisRuby
  module Api
    module Mixins
      module Requests
        # Settings for reminders sending when using the ’Pay Later’ feature
        module WpfRemindersAttributes

          attr_reader :reminder_language
          attr_writer :reminders

          # It must be a valid language abbreviation
          def reminder_language=(value)
            allowed_options attribute: __method__,
                            allowed: Api::Constants::I18n.all,
                            value: value.to_s.downcase,
                            allow_empty: true
          end

          # Settings for a single reminder. Upto three reminders are allowed
          def add_reminder(channel:, after:)
            raise InvalidArgumentError, 'Reminders exceed the allowed count of 3.' if reminders.count >= 3

            reminders << init_reminder(channel: channel, after: after)
          end

          protected

          # Reminders structure
          def reminders_structure
            return reminders if reminders.empty?

            reminders.map &:object_structure
          end

          private :reminders=

          # Reminder Data Object
          def init_reminder(channel:, after:)
            reminder = Utils::Options::Reminder.new

            reminder.channel = channel
            reminder.after   = after.to_i

            reminder
          end

          # The number of the sent reminders would be exactly as sent or configured and delivery failures could be
          # handled on demand. Also there will be no reminders sent if the WPF is already completed
          def reminders
            @reminders ||= []
          end

        end
      end
    end
  end
end
