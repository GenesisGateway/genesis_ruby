require 'genesis_ruby/builders/xml'
require 'genesis_ruby/builders/form'
require 'genesis_ruby/builders/json'
require 'genesis_ruby/errors/builder_error'

module GenesisRuby
  # Builder handler
  class Builder

    # Builder XML
    XML  = 'xml'.freeze

    # Builder JSON
    JSON = 'json'.freeze

    # Builder FORM
    FORM = 'form'.freeze

    # Initialize the Builder Interface based on the Request requirements
    def initialize(request_interface)
      case request_interface
      when XML then @builder_context = Builders::Xml.new
      when FORM then @builder_context = Builders::Form.new
      when JSON then @builder_context = Builders::Json.new
      else
        raise GenesisRuby::BuilderError, 'Invalid Builder interface!'
      end
    end

    # Get built document
    def document
      builder_context.output
    end

    # Parse tree-structure into Builder document
    def parse_structure(structure)
      builder_context.populate_nodes(structure)
    end

    private

    attr_accessor :builder_context

  end
end
