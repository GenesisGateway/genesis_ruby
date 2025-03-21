require 'genesis_ruby/parsers/base'
require 'json'

module GenesisRuby
  module Parsers
    # JSON Document parser
    class Json < Base

      # Parse received document
      def parse_document(document)
        @structure = JSON.parse(document, symbolize_names: true)
      rescue StandardError => e
        raise ParserError, "Given JSON string can not be parsed! #{e.message}"
      end

    end
  end
end
