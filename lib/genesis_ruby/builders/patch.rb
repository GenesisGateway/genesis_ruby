# frozen_string_literal: true

require 'genesis_ruby/builders/base'
require 'json'

module GenesisRuby
  module Builders
    # PATCH Document builder
    class Patch < Base

      # PATCH constructor
      def initialize
        @document = ''

        super
      end

      # PATCH output string
      def output
        @document
      end

      # Generate PATCH document
      def populate_nodes(structure)
        @document = JSON.pretty_generate structure
      rescue StandardError => e
        raise BuilderError, "Given request structure can not be generated! #{e.message}"
      end

    end
  end
end
