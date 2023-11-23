require 'genesis_ruby/builders/base'
require 'uri'

module GenesisRuby
  module Builders
    # XML, Nokogiri Builder Implementation
    class Form < Base

      # Initialize Nokogiri XML Builder
      def initialize
        @builder = URI
        super
      end

      # Generated HTTP Query Document
      def output
        document
      end

      def populate_nodes(structure)
        self.document = @builder.encode_www_form(transform_structure(structure))
      end

      private

      attr_accessor :buffer, :document

      # Transform structure from hash to array
      # { key: 'value' } -> [[key, value]]
      def transform_structure(structure)
        self.buffer = []
        structure.each { |key, value| add_buffer [key, value] }

        buffer
      end

      # Fill up parameters
      def add_buffer(value)
        @buffer.push(value)
      end

    end
  end
end
