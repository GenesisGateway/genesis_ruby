require 'genesis_ruby/builders/base'
require 'json'

module GenesisRuby
  module Builders
    # GraphQL builder
    class Graphql < Base

      # Builder GraphQL constructor
      def initialize
        @document = ''
        super
      end

      # Outputs generated document
      def output
        @document
      end

      # Created GraphQL query from provided structure
      def populate_nodes(structure)
        validate_structure(structure)

        @document = build_query(structure)
      end

      private

      # Validates given structure
      def validate_structure(structure)
        raise BuilderError, 'Invalid Hash structure given in Graphql builder!' unless structure.is_a? Hash

        root_key = structure.keys.first

        raise BuilderError, 'Missing structure root key in Graphql builder' if root_key.nil?
        raise BuilderError, 'Invalid GraphQL structure given in GraphQL builder' unless structure[root_key].is_a? Hash
      end

      # Build GraphQL Query
      def build_query(structure)
        ident           = ' ' * 2
        root_key        = structure.keys.first
        filters         = build_filters structure[root_key][:filters]
        response_fields = build_response_fields structure[root_key][:response_fields], ident * 2

        format("%{root} {\n#{ident}%{action}(%{filters})\n#{ident}{\n%{response_fields}\n#{ident}}\n}",
               root:            root_key,
               action:          structure[root_key][:action].to_s,
               filters:         filters,
               response_fields: response_fields)
      end

      # Build GraphQL filters
      def build_filters(data)
        out = ''

        return out unless data.is_a? Hash

        data.each do |key, value|
          out += splat_hash Hash[key, value]
          out += ', ' unless data.keys.last == key
        end

        out
      end

      # Builds given hash in the GraphQL syntax
      # { key: { key1: 'value1', key2: 'value2' } } becomes key: { key1: value1, key2: value2 }
      def splat_hash(data)
        out      = ''
        root_key = data.keys.first

        return out unless data[root_key].is_a? Hash

        data[root_key].each do |key, value|
          out += format '%{key}: %{value}', key: key.to_s, value: value.to_s
          out += ', ' unless key == data[root_key].keys.last
        end

        format '%{key}: { %{out} }', key: root_key, out: out
      end

      # Build GraphQL query response fields
      def build_response_fields(data, ident)
        out = ''

        return out unless data.is_a? Hash

        data.each do |key, value|
          out += formatted_array Hash[key, value], ident
          out += "\n" unless key == data.keys.last
        end

        out
      end

      # Build given array into formatted GraphQL query items
      # items: [item1 item2 item3] will output
      #   items
      #   {
      #     item1
      #     item2
      #     item3
      #   }
      def formatted_array(data, ident)
        out      = ''
        root_key = data.keys.first

        return out unless data[root_key].is_a? Array

        out += data[root_key].map { |key| "#{ident}  #{key}" }.join("\n")

        format "#{ident}%{key}\n#{ident}{\n%{out}\n#{ident}}", key: root_key, out: out
      end

    end
  end
end
