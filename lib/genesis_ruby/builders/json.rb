# frozen_string_literal: true

require 'genesis_ruby/builders/base'
require 'json'

module GenesisRuby
  module Builders
    # JSON Document builder
    class Json < Base

      # JSON constructor
      def initialize
        @document = ''

        super
      end

      # JSON output string
      def output
        @document
      end

      # Generate JSON document
      def populate_nodes(structure)
        @document = JSON.pretty_generate structure
      rescue StandardError => e
        raise BuilderError, "Given request structure can not be generated! #{e.message}"
      end

    end
  end
end
