module GenesisRuby
  module Parsers
    # Contract for every parser abstraction
    class Base

      attr_reader :structure, :root_node_skipped

      def initialize
        @structure         = {}
        @root_node_skipped = false
      end

      # Parse given document to Hash Structuce
      def parse_document(document)
        raise NotImplementedError, 'Parse Document must be implemented'
      end

      # Indicates that the Root element will not be included in the generated Object
      def skip_root_node
        @root_node_skipped = true
      end

    end
  end
end
