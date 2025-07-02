# frozen_string_literal: true

module GenesisRuby
  module Api
    module Mixins
      module Requests
        # Birth Date Attributes mixin
        module BirthDateAttributes

          # Birth Date Accessor
          def birth_date
            @birth_date&.strftime GenesisRuby::Api::Constants::DateTimeFormats::DD_MM_YYYY_L_HYPHENS
          end

          # Birth Date Accessor
          def birth_date=(value)
            parse_date attribute: __method__, value: value, allow_empty: true
          end

        end
      end
    end
  end
end
