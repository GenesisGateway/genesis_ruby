# frozen_string_literal: true

require 'genesis_ruby/utils/formatters/response/formats/amount'
require 'genesis_ruby/utils/formatters/response/formats/timestamp'

module GenesisRuby
  module Utils
    module Formatters
      # Definition of all available Response Formatters
      module Response

        # Array of string of all available Response Formatters
        def available_formatters
          [
            GenesisRuby::Utils::Formatters::Response::Formats::Amount,
            GenesisRuby::Utils::Formatters::Response::Formats::Timestamp
          ]
        end

      end
    end
  end
end
