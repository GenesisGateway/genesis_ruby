# frozen_string_literal: true

module GenesisSpec
  module Stubs
    module Api
      module Requests
        # WPF Reminders Attributes Stub
        class WpfRemindersAttributesStub

          include GenesisRuby::Api::Mixins::Requests::WpfRemindersAttributes
          include GenesisRuby::Api::Mixins::Requests::RestrictedSetter

        end
      end
    end
  end
end
