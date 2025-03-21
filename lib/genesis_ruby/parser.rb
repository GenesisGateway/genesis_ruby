require 'genesis_ruby/parsers/xml'
require 'genesis_ruby/parsers/json'
require 'genesis_ruby/errors/parser_error'

module GenesisRuby
  # Parser handler
  class Parser

    # XML Parser
    XML  = 'xml'.freeze

    # JSON Parser
    JSON = 'json'.freeze

    # Initialize the Parser Interface based on the Response requirements
    def initialize(response_interface)
      case response_interface
      when XML
        @parser_context = GenesisRuby::Parsers::Xml.new
      when JSON
        @parser_context = GenesisRuby::Parsers::Json.new
      else
        raise GenesisRuby::ParserError, 'Invalid Parser interface!'
      end
    end

    # Parsed document
    def structure
      parser_context.structure
    end

    # Parse tree-structure into Builder document
    def parse_document(document)
      parser_context.parse_document(document)
    end

    # Indicates that the Root element will not be included in the generated Object
    def skip_root_node
      parser_context.skip_root_node
    end

    private

    attr_accessor :parser_context

  end
end
