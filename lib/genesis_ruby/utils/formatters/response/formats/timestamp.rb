require 'genesis_ruby/utils/formatters/base'
require 'date'

module GenesisRuby
  module Utils
    module Formatters
      module Response
        module Formats
          # Response Timestamp format
          class Timestamp < Base

            # The Response keys that the formatter will be applied to
            def formatting_keys
              %w(timestamp transactionDate valueDate)
            end

            # Format the given timestamp to DateTime object
            def format_key(timestamp)
              DateTime.parse timestamp
            rescue StandardError
              timestamp
            end

          end
        end
      end
    end
  end
end
