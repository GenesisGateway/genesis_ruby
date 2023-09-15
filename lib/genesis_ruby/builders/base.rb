module GenesisRuby
  module Builders
    # Contract for every builder abstraction
    class Base

      # Get the Generated Builder Output
      def output
        raise NotImplementedError, 'Output must be implemented'
      end

      # Tree-structured hash representing the request structure
      def populate_nodes(structure)
        raise NotImplementedError, 'Populate Nodes must be implemented'
      end

    end
  end
end
