# frozen_string_literal: true

module GenesisRuby
  module Api
    module Constants
      # Date Time string representation formats
      class DateTimeFormats

        extend Mixins::Constants::Common

        # Little endian(day, month, year) system with hyphens in between
        DD_MM_YYYY_L_HYPHENS  = '%d-%m-%Y'

        # Little endian(day, month, year) system with dots in between
        DD_MM_YYYY_L_DOTS     = '%d.%m.%Y'

        # Little endian(day, month, year) system with dots in between
        DD_MM_YYYY_L_SLASHES  = '%d/%m/%Y'

        # Zulu timestamp
        YYYY_MM_DD_H_I_S_ZULU = '%Y-%m-%dT%H:%M:%SZ'

        # Modified Zulu timestamp
        YYYY_MM_DD_H_I_S      = '%Y-%m-%d %H:%M:%S'

        # Date Format ISO 8601
        YYYY_MM_DD_ISO_8601   = '%Y-%m-%d'

        # Date Format
        MM_DD                 = '%m%d'

        class << self

          def all
            [
              DD_MM_YYYY_L_HYPHENS,
              DD_MM_YYYY_L_DOTS,
              DD_MM_YYYY_L_SLASHES,
              YYYY_MM_DD_H_I_S_ZULU,
              YYYY_MM_DD_H_I_S,
              MM_DD,
              YYYY_MM_DD_ISO_8601 # Always keep it last!!!
            ]
          end

        end

      end
    end
  end
end
